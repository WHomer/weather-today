class Api::V1::MunchiesController < ApplicationController
  def index
    start_location = params[:start]
    end_location = params[:end]
    category = params[:food]
    google = GoogleService.new()
    response = google.get_travel_time(start_location, end_location)
    time_in_seconds = response[:routes][0][:legs][0][:duration][:value]

    yelp = YelpService.new()
    arrival_time = (Time.now + time_in_seconds.seconds).to_i 
    yelp_response = yelp.get_restaurants(end_location, arrival_time, category)


    render json: MunchieSerializer.new(yelp_response).munchies
  end
end