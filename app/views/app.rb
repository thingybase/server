# frozen_string_literal: true

class Views::App < Views::Base
  def around_template(&)
    super do
      layout = Views::Layouts::App.new(title:)
      layout.opengraph.tap do
        it.image_url = image_url
        it.title = title
      end

      render layout do
        yield
      end
    end
  end

  def title = "Thingybase is rad"
  def image_url = nil
end
