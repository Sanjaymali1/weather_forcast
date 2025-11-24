# Fetches weather details.
# Handles caching + API calls.
# Returns Forecast value object.

class WeatherFetcherService
  include HTTParty
  base_uri "https://api.open-meteo.com/v1"

  CACHE_EXPIRE = 30.minutes

  def self.fetch(lat, lon, zip)
    cache_key = "weather_#{zip}"

    if (cached = Rails.cache.read(cache_key))
      return Forecast.new(
        current_temp:  cached[:current_temp],
        high:          cached[:high],
        low:           cached[:low],
        forecast_text: cached[:forecast_text],
        source:        "CACHE"
      )
    end

    response = get("/forecast", query: {
      latitude: lat,
      longitude: lon,
      current_weather: true,
      daily: "temperature_2m_max,temperature_2m_min,weathercode",
      timezone: "auto"
    })

    weather = response.parsed_response

    current  = weather["current_weather"]["temperature"]
    high     = weather["daily"]["temperature_2m_max"][0]
    low      = weather["daily"]["temperature_2m_min"][0]
    code     = weather["daily"]["weathercode"][0]
    forecast = weather_description(code)

    # store in Rails cache
    Rails.cache.write(
      cache_key,
      {
        current_temp: current,
        high: high,
        low: low,
        forecast_text: forecast
      },
      expires_in: CACHE_EXPIRE
    )

    Forecast.new(
      current_temp: current,
      high: high,
      low: low,
      forecast_text: forecast,
      source: "API"
    )
  end

  # Converts numeric weather code → human readable text
  def self.weather_description(code)
    mapping = {
      0 => "Clear sky",
      1 => "Mainly clear",
      2 => "Partly cloudy",
      3 => "Overcast",
      51 => "Light drizzle",
      61 => "Light rain",
      80 => "Rain showers",
      95 => "Thunderstorm"
    }

    mapping[code] || "Weather data unavailable"
  end
end
