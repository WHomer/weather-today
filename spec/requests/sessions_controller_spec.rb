require 'rails_helper'

RSpec.describe 'users controller' do
  describe 'create', :type => :request do
    before :each do
      User.create!(email: 'whatever@example.com',
        password: 'password')

      body = {
        "email": "whatever@example.com",
        "password": "password",
      }
      type = {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      }
      post '/api/v1/sessions', params: body.to_json, headers: type
      @body = JSON.parse(request.body.string, symbolize_names: true)
    end

    it 'has an variables' do
      expect(@body[:email]).to eq('whatever@example.com')
      expect(@body[:password]).to eq('password')
    end

    it 'returns an api key' do
      expect(JSON.parse(response.body)).to have_key('api_key')
      expect(JSON.parse(response.body)['api_key']).to be_kind_of(String)
    end

    it 'should return a status of 200' do
      expect(response).to have_http_status(:success)
    end
  end
end