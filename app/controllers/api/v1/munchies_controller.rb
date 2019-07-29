class Api::V1::MunchiesController < ApplicationController
  def index
    start_location = params[:start]
    end_location = params[:end]
    google = GoogleService.new()
    response = google.get_travel_time(start_location, end_location)
    time_in_seconds = response[:routes][0][:legs][0][:duration][:value]

    
    require 'pry'; binding.pry
    render json: {}
  end
end