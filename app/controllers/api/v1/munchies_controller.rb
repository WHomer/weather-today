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
    response = yelp.get_restaurants(end_location, arrival_time, category)

    restaurants = response[:businesses].map do |business|
      {
        name: business[:name],
        address: business[:location][:display_address].to_s
      }
    end
    results = {
      destination_city: response[:businesses][0][:location][:city],
      restaurants: restaurants
    }


    render json: results
  end
end