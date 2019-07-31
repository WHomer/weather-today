# frozen_string_literal: true

module Api
  module V1
    # Users Controller
    class UsersController < ApplicationController
      def create
        user = User.new(user_params)
        render json: { api_key: user.api_key }, status: :created if user.save
      end

      private

      def user_params
        params.permit(:email, :password, :password_confirmation)
      end
    end
  end
end
