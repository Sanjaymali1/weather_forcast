# Represents a weather forecast with current, high, low temps, and description.
# Immutable object to ensure safe use across the application.

class Forecast
  attr_reader :current_temp, :high, :low, :forecast_text, :source

  def initialize(current_temp:, high:, low:, forecast_text: nil, source:)
    @current_temp   = current_temp
    @high           = high
    @low            = low
    @forecast_text  = forecast_text
    @source         = source
    freeze  # makes object immutable
  end
end
