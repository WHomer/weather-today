class ImageUrlSerializer
  attr_reader :url, :alt_text

  def initialize(image_data)
    @url = generate_url(image_data)
    @alt_text = image_data[:title]
  end

  def return_json
    {
      alt_text: @alt_text,
      url: @url
    }
  end

  private
  
  def generate_url(data)
    "https://farm#{ data[:farm] }.staticflickr.com/#{ data[:server] }/#{ data[:id] }_#{ data[:secret] }.jpg"
  end
end
