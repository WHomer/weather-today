class Forecast
  def initialize(data)
    @data = data
  end

  def current_weather
    current = @data[:currently]
    {
      time: current[:time],
      summary: current[:summary],
      icon: current[:icon],
      precipProbability: current[:precipProbability],
      precipType: current[:precipType],
      temperature: current[:temperature],
      apparentTemperature: current[:apparentTemperature],
      humidity: current[:humidity],
      uvIndex: current[:uvIndex],
      visibility: current[:visibility]
    }
  end

  def daily_weather
    daily = @data[:daily][:data]
    daily.map do |day|
      {
        time: day[:time],
        icon: day[:icon],
        precipProbability: day[:precipProbability],
        precipType: day[:precipType],
        temperatureHigh: day[:temperatureHigh],
        temperatureLow: day[:temperatureLow]
      }
    end
  end

  def hourly_weather
    hourly = @data[:hourly][:data]
    hourly.map do |hour|
      {
        time: hour[:time],
        summary: hour[:summary],
        icon: hour[:icon],
        temperature: hour[:temperature]
      }
    end
  end
end