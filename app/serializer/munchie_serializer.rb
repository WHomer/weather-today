class MunchieSerializer
  def initialize(restaurants)
    @restaurants = restaurants
  end

  def munchies
    {
      destination_city: @restaurants[:businesses][0][:location][:city],
      restaurants: munchify_restaurants
    }
  end

  private

  def munchify_restaurants
    @restaurants[:businesses].map do |business|
      {
        name: business[:name],
        address: business[:location][:display_address].to_s
      }
    end
  end
end