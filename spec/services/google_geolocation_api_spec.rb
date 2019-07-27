require 'rails_helper'

RSpec.describe GoogleGeolocationService do
  before :each do
    @geolocation_service = GoogleGeolocationService.new()
  end

  it 'exists' do
    expect(@geolocation_service).to be_a(GoogleGeolocationService)
  end

  it '.get_geocode' do
    address = 'Denver, CO'
    response = @geolocation_service.get_geocode(address)
    response_location = response[:results][0][:geometry][:location]
    expect(response).to be_an(Hash)
    expect(response_location[:lat]).to be_kind_of(Float)
    expect(response_location[:lng]).to be_kind_of(Float)
    expect(response_location[:lat]).to a_value_between(-90, 90)
    expect(response_location[:lng]).to a_value_between(-180, 180)
  end

end