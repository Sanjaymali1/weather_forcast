# A value object representing weather forecast information.
# Immutable and validated structure promoting clean architecture.

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
