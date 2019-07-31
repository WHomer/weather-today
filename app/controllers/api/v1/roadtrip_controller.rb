class Api::V1::RoadtripController < ApplicationController
  def show
    facade = RoadtripShowFacade.new(params)
    if current_user
      render json: RoadtripSerializer.new(facade).forecast
    else
      render json: {
        message: 'no API key or an incorrect key was provided'
      }, status: :unauthorized
    end
  end
end