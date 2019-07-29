require 'rails_helper'

RSpec.describe 'munchies controller' do
  describe 'index' do
    before :each do
      get '/api/v1/munchies?start=denver,co&end=pueblo,co&food=chinese'
    end

    it 'should return a status of 200' do
      expect(response).to be_successful
    end

    it 'should return JSON of three foods and city' do
      data = JSON.parse(response.body, symbolize_names: true)

      expect(data).to be_an(Hash)
    end
  end
end
