# frozen_string_literal: true

# API service for Flicker
class FlickrService
  def initialize; end

  def get_city_backgrounds(location)
    params = {
      method: 'flickr.photos.search',
      text: "#{location} skyline downtown"
    }
    get_json(params)
  end

  private

  def get_json(params)
    response = conn.get('', params)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new('https://www.flickr.com/services/rest/') do |f|
      f.params['api_key'] = ENV['FLICKER_API_KEY']
      f.params['format'] = 'json'
      f.params['nojsoncallback'] = 1
      f.adapter Faraday.default_adapter
    end
  end
end
