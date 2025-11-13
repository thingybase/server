# spec/views/hello/show.html.erb_spec.rb
require "rails_helper"

RSpec.describe Components::Card, type: :view do
  def render(...)
    controller.view_context.render(...)
  end

  def render_fragment(...)
    Nokogiri::HTML5.fragment(render(...))
  end

  it "renders a card-title" do
    html = render Components::Card::Text.new do |card|
      card.header do
        it.title { "HI" }
      end
    end

    dom = Nokogiri::HTML5.fragment(html)
    expect(dom.css(".card-title").text).to eq("HI")
  end
end
