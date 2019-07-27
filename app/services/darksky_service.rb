class DarkskyService
  def initialize()
    @api_key = ENV['DARKSKY_API_KEY']
  end

  def get_forecast(lat_lng)
    path = "forecast/#{@api_key}/#{lat_lng}"
    get_json(path)
  end

  private

  def get_json(path, params = {})
    response = conn.get(path, params)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new("https://api.darksky.net/")
  end
end