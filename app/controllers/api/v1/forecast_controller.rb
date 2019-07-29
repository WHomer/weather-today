class Api::V1::ForecastController < ApplicationController
  def show
    render json: forecast_data(params[:location])
  end

  private

  def forecast_data(location)
    geolocation = GoogleService.new.get_geocode(location)
    lat_lng_string = geolocation[:results][0][:geometry][:location].values.join(',')
    forecast = DarkskyService.new.get_forecast(lat_lng_string)

    forecast_serializer = ForecastSerializer.new(geolocation, forecast)
    forecast_serializer.get_forecast
  end
end