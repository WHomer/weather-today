class ForecastSerializer
  def initialize(geolocation, forecast)
    @geolocation = geolocation
    @forecast = forecast
  end

  def get_forecast
    address = @geolocation[:results][0][:formatted_address]
    daily = daily_forecasts(@forecast[:daily][:data])
    hourly = hourly_forecasts(@forecast[:hourly][:data])
    current = current_weather(@forecast[:currently])
    forecast_response(address, daily, hourly, current)
  end

  private

  def forecast_response(address, daily, hourly, current)
    {
      "address": address,
      "current_weather": JSON.parse(current),
      "daily_forecast": {"data": JSON.parse(daily) },
      "hourly_forecast": {"data": JSON.parse(hourly) }
    }
  end

  def current_weather(data)
    data.to_json(only: [:time, :summary, :icon, :precipProbability, :precipType, :temperature, :apparentTemperature, :humidity, :uvIndex, :visibility])
  end

  def hourly_forecasts(data)
    data.map.to_json(only: [:time, :summary, :icon, :temperature])
  end

  def daily_forecasts(data)
    data.map.to_json(only: [:time, :icon, :precipProbability, :precipType, :temperatureHigh, :temperatureLow])
  end
end