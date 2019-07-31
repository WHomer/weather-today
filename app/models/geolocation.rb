class Geolocation
  def initialize(data)
    @data = data
  end

  def lat_lng
    @data[:results][0][:geometry][:location]
  end

  def formated_address
    @data[:results][0][:formatted_address]
  end
end