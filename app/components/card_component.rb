class CardComponent < ApplicationComponent
  def initialize(url:, title:, subtitle:, image_url:)
    @url = url
    @title = title
    @subtitle = subtitle
    @image_url = image_url
  end

  def template
    a(href: @url, class: "card shadow-xl max-w-96 transition hover:scale-105 hover:shadow-2xl") do
      figure(class: "max-h-64 rounded-t-2xl") do
        helpers.image_tag @image_url
      end
      div(class: "card-body") do
        h3(class: "font-bold text-xl") { @title }
        p { @subtitle }
        div(class: "card-actions justify-end") do
          button(class: "btn") { "Read more →" }
        end
      end
    end
  end
end
