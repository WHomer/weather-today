# frozen_string_literal: true

# Serializer for Forecast Serializer
class ForecastSerializer
  include FastJsonapi::ObjectSerializer

  attributes :address, :current_weather, :daily_weather, :hourly_weather
end
