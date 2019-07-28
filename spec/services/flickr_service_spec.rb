require 'rails_helper'

RSpec.describe FlickrService do
  before :each do
    @flickr_service = FlickrService.new()
  end

  it 'exists' do
    expect(@flickr_service).to be_a(FlickrService)
  end

  it '.get_backgrounds' do
    response = @flickr_service.get_city_backgrounds('denver,co')
    expect(response).to be_an(Hash)
  end

end