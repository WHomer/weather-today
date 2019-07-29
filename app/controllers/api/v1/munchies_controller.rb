class Api::V1::MunchiesController < ApplicationController
  def index
    start_location = params[:start]
    end_location = params[:end]
    google = GoogleService.new()
    response = google.get_travel_time(start_location, end_location)
    travel_time = response

    render json: {}
  end
end