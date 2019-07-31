# frozen_string_literal: true

module Api
  module V1
    # Sessions Controller
    class SessionsController < ApplicationController
      def create
        user = User.find_by(email: params[:email])
        render json: { api_key: user.api_key } if user&.authenticate(params[:password])
      end
    end
  end
end
