# frozen_string_literal: true

module Api
  module V1
    # Background Controller
    class BackgroundController < ApplicationController
      def index
        render json: background_images_by_city(params['location'])
      end

      private

      def background_images_by_city(location)
        flickr_service = FlickrService.new
        image_results = flickr_service.get_city_backgrounds(location)
        results = serialize_images(image_results[:photos][:photo])
        { data: results }.to_json
      end

      def serialize_images(images)
        images.map do |image|
          ImageUrlSerializer.new(image).return_json
        end
      end
    end
  end
end
