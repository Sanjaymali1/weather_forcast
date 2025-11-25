# spec/services/weather_fetcher_service_spec.rb
require "rails_helper"

RSpec.describe WeatherFetcherService, type: :service do
  let(:lat) { 18.5204 }
  let(:lon) { 73.8567 }
  let(:zip) { "411001" }

  before { Rails.cache.clear }

  describe ".fetch" do
    it "fetches weather and returns a Forecast object" do
      fake_response = double(
        "response",
        success?: true,
        parsed_response: {
          "current_weather" => { "temperature" => 28 },
          "daily" => { "temperature_2m_max" => [30], "temperature_2m_min" => [25] }
        }
      )
      allow(HTTParty).to receive(:get).and_return(fake_response)

      forecast = WeatherFetcherService.fetch(lat, lon, zip)

      expect(forecast).to be_a(Forecast)
      expect(forecast.current_temp).to eq(29.4)
      expect(forecast.high).to eq(30)
      expect(forecast.low).to eq(25)
      expect(forecast.forecast_text).to eq("Mainly clear")
      expect(forecast.source).to eq("API")
    end
  end
end
