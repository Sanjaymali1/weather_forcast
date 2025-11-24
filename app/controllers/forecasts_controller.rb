class ForecastsController < ApplicationController
  def index
  end

  def fetch_weather
    @address = params[:address]

    return flash.now[:alert] = "Please enter an address" if @address.blank?

    # Convert address → lat/lon/zip
    geo = GeocodingService.lookup(@address)
    return flash.now[:alert] = "Unable to find location" unless geo

    @data = WeatherFetcherService.fetch(geo[:lat], geo[:lon], geo[:zip])
    @zip = geo[:zip]
  end
end