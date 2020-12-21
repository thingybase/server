class CardComponent < ViewComponent::Base
  def initialize(url:, title:, subtitle:, image_url:)
    @url = url
    @title = title
    @subtitle = subtitle
    @image_url = image_url
  end
end
