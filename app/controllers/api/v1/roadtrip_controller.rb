class Api::V1::RoadtripController < ApplicationController
  def show
    if current_user
      render json: {
        'temperature': hour_forecast_for_location[:temperature],
        'summary': hour_forecast_for_location[:summary],
        'travel_time': travel_time_in_seconds
      }
    else
      render json: {
        message: 'no API key or an incorrect key was provided'
      }, status: :unauthorized
    end
  end

  private

  def hour_forecast_for_location
    response = DarkskyService.new.get_forecast(end_location_lat_lng)
    hourly_data = response[:hourly][:data]
    hourly_data.min_by do |hour|
      (hour[:time] - (Time.now + travel_time_in_seconds.seconds).to_i).abs
    end
  end

  def travel_time_in_seconds
    google = GoogleService.new()
    response = google.get_travel_time(start_location, end_location)
    response[:routes][0][:legs][0][:duration][:value]
  end

  def end_location_lat_lng
    google = GoogleService.new()
    response = google.get_travel_time(start_location, end_location)
    response[:routes][0][:legs][0][:end_location].values.join(',')
  end

  def start_location
    params[:origin]
  end

  def end_location
    params[:destination]
  end

end