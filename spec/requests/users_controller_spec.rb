require 'rails_helper'

RSpec.describe 'users controller' do
  describe 'create', :type => :request do
    before :each do
      body = {
        "email": "whatever@example.com",
        "password": "password",
        "password_confirmation": "password"
      }
      type = {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      }
      post '/api/v1/users', params: body.to_json, headers: type
      @body = JSON.parse(request.body.string, symbolize_names: true)
    end

    it 'has an variables' do
      expect(@body[:email]).to eq('whatever@example.com')
      expect(@body[:password]).to eq('password')
      expect(@body[:password_confirmation]).to eq('password')
    end

    it 'returns an api key' do
      expect(JSON.parse(response.body)).to have_key('api_key')
      expect(JSON.parse(response.body)['api_key']).to be_kind_of(String)
    end

    it 'creates a user successfully' do
      expect(User.last.email).to eq('whatever@example.com')
    end

    it 'should return a status of 201' do
      expect(response).to have_http_status(:created)
    end
  end
end