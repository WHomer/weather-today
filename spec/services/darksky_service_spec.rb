require 'rails_helper'

RSpec.describe DarkskyService, :vcr do
  before :each do
    @darksky_service = DarkskyService.new()
  end

  it 'exists' do
    expect(@darksky_service).to be_a(DarkskyService)
  end

  it '.get_forecast' do
    lat_lng = "37.8267,-122.4233"
    response = @darksky_service.get_forecast(lat_lng)
    expect(response).to be_an(Hash)
    
    current_weather = response[:currently]
    expect(current_weather[:time]).to be_kind_of(Integer)
    expect(current_weather[:temperature]).to be_kind_of(Float)
    expect(current_weather[:apparentTemperature]).to be_kind_of(Float)
    expect(current_weather[:humidity]).to be_kind_of(Float)
    expect(current_weather[:visibility]).to be_kind_of(Float)
    expect(current_weather[:uvIndex]).to be_kind_of(Integer)

    todays_weather = response[:daily][:data][0]
    expect(todays_weather[:temperatureHigh]).to be_kind_of(Float)
    expect(todays_weather[:temperatureLow]).to be_kind_of(Float)
    expect(todays_weather[:summary]).to be_kind_of(String)
    expect(todays_weather[:icon]).to be_kind_of(String)
    # expect(todays_weather[:precipProbability]).to be_kind_of(Float)
    # expect(todays_weather[:precipType]).to be_kind_of(String)

    daily_weather = response[:daily][:data]
    expect(daily_weather.length > 4).to eq(true)
  end
end