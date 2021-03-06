require 'rails_helper'

RSpec.describe 'munchies controller', :vcr do
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

      expect(data[:restaurants].count).to  eq(3)
      expect(data[:destination_city]).to be_kind_of(String)
      expect(data[:restaurants][0][:name]).to be_kind_of(String)
      expect(data[:restaurants][0][:address]).to be_kind_of(String)
      expect(data[:restaurants][1][:name]).to be_kind_of(String)
      expect(data[:restaurants][1][:address]).to be_kind_of(String)
      expect(data[:restaurants][2][:name]).to be_kind_of(String)
      expect(data[:restaurants][2][:address]).to be_kind_of(String)
    end
  end
end
