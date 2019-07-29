class Api::V1::MunchiesController < ApplicationController
  def index
    results = three_open_restaurants_by_location_and_category

    render json: MunchieSerializer.new(results).munchies
  end

  private

  def three_open_restaurants_by_location_and_category
    yelp = YelpService.new()
    arrival_time = (Time.now + travel_time_in_seconds.seconds).to_i 
    yelp_response = yelp.get_restaurants(end_location, arrival_time, category)
  end

  def travel_time_in_seconds
    google = GoogleService.new()
    response = google.get_travel_time(start_location, end_location)
    response[:routes][0][:legs][0][:duration][:value]
  end

  def start_location
    params[:start]
  end

  def end_location
    params[:end]
  end

  def category
    params[:category]
  end

end