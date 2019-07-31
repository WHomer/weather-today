# frozen_string_literal: true

module Api
  module V1
    # Roadtrip Controller
    class RoadtripController < ApplicationController
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
  end
end
