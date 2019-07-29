require 'rails_helper'

RSpec.describe GoogleService do
  before :each do
    @google_service = GoogleService.new()
  end

  it 'exists' do
    expect(@google_service).to be_a(GoogleService)
  end

  it '.get_geocode' do
    address = 'Denver, CO'
    response = @google_service.get_geocode(address)
    response_location = response[:results][0][:geometry][:location]
    expect(response).to be_an(Hash)
    expect(response_location[:lat]).to be_kind_of(Float)
    expect(response_location[:lng]).to be_kind_of(Float)
    expect(response_location[:lat]).to a_value_between(-90, 90)
    expect(response_location[:lng]).to a_value_between(-180, 180)
  end

  it '.get_travel_time' do
    start_loc = 'Denver, CO'
    end_loc = 'Pueblo, CO'
    response = @google_service.get_travel_time(start_loc, end_loc)
    expect(response).to be_an(Hash)
    time_in_seconds = response[:routes][0][:legs][0][:duration][:value]
    expect(time_in_seconds).to be_kind_of(Integer)
  end

end