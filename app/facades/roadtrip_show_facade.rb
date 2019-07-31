class RoadtripShowFacade
  attr_reader :start_location,
              :end_location,
              :arrival_temperature,
              :arrival_weather_summary,
              :travel_time_in_seconds

  def initialize(params)
    @start_location = params[:origin]
    @end_location = params[:destination]
    @api_key = params[:api_key]
    @travel_time_in_seconds = travel_time
    @arrival_temperature = end_location_forecast[:temperature]
    @arrival_weather_summary = end_location_forecast[:summary]
  end

  def end_location_forecast
    hourly_data = forecast_information[:hourly][:data]
    @result ||= hourly_data.min_by do |hour|
      (hour[:time] - (Time.now + @travel_time_in_seconds.seconds).to_i).abs
    end
  end

  private

  def travel_time
    # results are back in seconds
    travel_inforamtion[:routes][0][:legs][0][:duration][:value]
  end

  def travel_inforamtion
    @get_travel_time ||= GoogleService.new
      .get_travel_time(@start_location, @end_location)
  end

  def forecast_information
    @get_forecast ||= DarkskyService.new
      .get_forecast(end_location_lat_lng)
  end

  def end_location_lat_lng
    # results are back in String ex'75.000,-32.000'
    travel_inforamtion[:routes][0][:legs][0][:end_location].values.join(',')
  end

end