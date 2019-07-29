class GoogleService
  def initialize()

  end

  def get_geocode(location)
    params = { address: location }
    get_json('geocode/json', params)
  end

  def get_travel_time(start_loc, end_loc)
    params = {
      origin: start_loc,
      destination: end_loc,
      travelMode: 'DRIVING'
    }
    get_json('directions/json', params)
  end

  private

  def get_json(path, params)
    response = conn.get(path, params)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new("https://maps.googleapis.com/maps/api/") do |f|
      f.params['key'] = ENV['GOOGLE_API_GEOLOCATION']
      f.adapter Faraday.default_adapter
    end
  end
end