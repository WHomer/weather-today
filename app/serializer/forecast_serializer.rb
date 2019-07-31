# frozen_string_literal: true

# Serializer for Forecast Serializer
class ForecastSerializer
  def initialize(facade)
    @facade = facade
  end

  def forecast
    {
      "address": @facade.formatted_address,
      "current_weather": @facade.current_weather,
      "daily_forecast": { "data": @facade.daily_weather },
      "hourly_forecast": { "data": @facade.hourly_weather }
    }
  end

end
