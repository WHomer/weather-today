class YelpService
  def initialize()
  end

  def get_restaurants(location, open_at, categories)
    params = {
      location: location,
      limit: 3,
      open_at: open_at,
      categories: categories
    }
    get_json('businesses/search', params)
  end

  private

  def get_json(path, params)
    response = conn.get(path, params)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new("https://api.yelp.com/v3") do |f|
      f.headers['Authorization'] = "Bearer #{ENV['YELP_API_KEY']}"
      f.adapter Faraday.default_adapter 
    end
  end
end