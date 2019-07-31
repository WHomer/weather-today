# frozen_string_literal: true

class ForecastShowFacade
  attr_reader :formatted_address,
              :current_weather,
              :daily_weather,
              :hourly_weather

  def initialize(params)
    @location = params[:location]
    # @formatted_address = geolocation.formated_address
    # @current_weather = forecast.current_weather
    # @daily_weather = forecast.daily_weather
    # @hourly_weather = forecast.hourly_weather
  end

  def forecast_api_data
    lat_lng_string = geolocation.lat_lng.values.join(',')
    @forecast_api_data ||= DarkskyService.new.get_forecast(lat_lng_string)
  end

  def forecast
    address = geolocation.formated_address
    @forecast ||= Forecast.new(forecast_api_data, address)
  end

  def geocode_api_data
    @geocode_api_data ||= GoogleService.new.get_geocode(@location)
  end

  def geolocation
    Geolocation.new(geocode_api_data) 
  end
end