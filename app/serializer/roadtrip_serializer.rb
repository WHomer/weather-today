# frozen_string_literal: true

# Serializer for Roadtrip Serializer
class RoadtripSerializer
  def initialize(facade)
    @roadtrip_facade = facade
  end

  def forecast
    {
      'temperature': @roadtrip_facade.arrival_temperature,
      'summary': @roadtrip_facade.arrival_weather_summary,
      'travel_time': @roadtrip_facade.travel_time_in_seconds
    }
  end
end
