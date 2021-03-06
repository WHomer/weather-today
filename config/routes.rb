# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'forecast', to: 'forecast#show'
      get 'backgrounds', to: 'background#index'
      get 'munchies', to: 'munchies#index'

      post 'sessions', to: 'sessions#create'
      post 'users', to: 'users#create'
      post 'road_trip', to: 'roadtrip#show'
    end
  end
end
