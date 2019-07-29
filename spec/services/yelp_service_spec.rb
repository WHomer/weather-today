require 'rails_helper'

RSpec.describe YelpService do
  before :each do
    @yelp = YelpService.new()
  end

  it 'exists' do
    expect(@yelp).to be_a(YelpService)
  end

  it '.get_restaurants' do
    location = 'Denver, CO'
    open_at = 1564415520
    categories = 'chinese, All'

    response = @yelp.get_restaurants(location, open_at, categories)
    expect(response).to be_an(Hash)
    expect(response[:businesses].count).to eq(3)
    expect(response[:businesses][0][:name]).to be_kind_of(String)
    expect(response[:businesses][0][:location][:display_address]).to be_kind_of(Array)
  end

end