require 'rails_helper'

RSpec.describe 'forecast controller' do
  describe 'show' do
    before :each do
      get "/api/v1/forecast?location=denver,co"
    end
    it 'should return a status of 200' do
      expect(response).to be_successful
    end

    it 'should return JSON of weather by city' do
      data = JSON.parse(response.body, symbolize_names: true)

      expect(data).to be_an(Hash)
      expect(data[:address]).to eq('Denver, CO, USA')

      current_weather = data[:current_weather]
      expect(current_weather[:time]).to be_kind_of(Integer)
      expect(current_weather[:summary]).to be_kind_of(String)
      expect(current_weather[:icon]).to be_kind_of(String)
      expect(current_weather[:precipProbability] >= 0).to eq(true)
      # expect(current_weather).to include(:precipType)
      expect(current_weather[:temperature]).to be_kind_of(Float)
      expect(current_weather[:apparentTemperature]).to be_kind_of(Float)
      expect(current_weather[:humidity]).to be_kind_of(Float)
      expect(current_weather[:uvIndex]).to be_kind_of(Integer)
      expect(current_weather).to have_key(:visibility)
      # expect(current_weather[:visibility]).to be_kind_of(Float)

      daily_forecast = data[:daily_forecast][:data][0]
      expect(data[:daily_forecast][:data].length > 4).to eq(true)
      expect(daily_forecast[:time]).to be_kind_of(Integer)
      expect(daily_forecast[:icon]).to be_kind_of(String)
      expect(daily_forecast).to include(:precipProbability)
      # expect(daily_forecast).to have_key(:precipType)
      expect(daily_forecast[:temperatureHigh]).to be_kind_of(Float)
      expect(daily_forecast[:temperatureLow]).to be_kind_of(Float)

      hourly_forcast = data[:hourly_forecast][:data][0]
      expect(data[:hourly_forecast][:data].length > 7).to eq(true)
      expect(hourly_forcast[:time]).to be_kind_of(Integer)
      expect(hourly_forcast[:summary]).to be_kind_of(String)
      expect(hourly_forcast[:icon]).to be_kind_of(String)
      expect(hourly_forcast[:temperature]).to be_kind_of(Float)
    end
  end

end
