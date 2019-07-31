require 'rails_helper'

RSpec.describe 'users controller', :vcr do
  describe 'create', :type => :request do
    before :each do
      @user_1 = User.create!(email: 'whatever@example.com',
        password: 'password')

      body = {
        "origin": "Denver,CO",
        "destination": "Pueblo,CO",
        "api_key": @user_1.api_key
      }
      type = {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      }
      post '/api/v1/road_trip', params: body.to_json, headers: type
      @body = JSON.parse(request.body.string, symbolize_names: true)
    end

    it 'has variables' do
      expect(@body[:origin]).to eq('Denver,CO')
      expect(@body[:destination]).to eq('Pueblo,CO')
      expect(@body[:api_key]).to eq(@user_1.api_key)
    end

    it 'returns temp, summary, travel_time key' do
      expect(JSON.parse(response.body)).to have_key('temperature')
      expect(JSON.parse(response.body)['temperature']).to be_kind_of(Float)
      expect(JSON.parse(response.body)).to have_key('summary')
      expect(JSON.parse(response.body)['summary']).to be_kind_of(String)
      expect(JSON.parse(response.body)).to have_key('travel_time')
      expect(JSON.parse(response.body)['travel_time']).to be_kind_of(Integer)
    end

    it 'should return a status of 200' do
      expect(response).to have_http_status(:success)
    end
  end

  describe 'create sad paths' do

    it 'returns 401 if unautherized api_key' do
      body = {
        "origin": "Denver,CO",
        "destination": "Pueblo,CO",
        "api_key": 'incorrect_key'
      }
      type = {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      }
      post '/api/v1/road_trip', params: body.to_json, headers: type

      expect(response).to have_http_status(:unauthorized)
    end
  end
end
