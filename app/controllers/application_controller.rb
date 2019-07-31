# frozen_string_literal: true

# ApplicationController
class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  private

  def current_user
    @current_user ||= User.find_by(api_key: params[:api_key]) if params[:api_key]
  end
end
