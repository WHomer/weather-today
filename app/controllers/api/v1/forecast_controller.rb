# frozen_string_literal: true

module Api
  module V1
    # Forecast Controller
    class ForecastController < ApplicationController
      def show
        facade = ForecastShowFacade.new(params)
        render json: ForecastSerializer.new(facade.forecast)
      end
    end
  end
end
