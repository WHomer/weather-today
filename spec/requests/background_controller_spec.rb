require 'rails_helper'

RSpec.describe 'backgrounds controller', :vcr do
  describe 'index' do
    before :each do
      get '/api/v1/backgrounds?location=denver,co'
    end

    it 'should return a status of 200' do
      expect(response).to be_successful
    end

    it 'should return JSON of background images by city' do
      data = JSON.parse(response.body, symbolize_names: true)
      expect(data).to be_an(Hash)
    end
  end
end
