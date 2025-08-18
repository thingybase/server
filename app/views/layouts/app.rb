# frozen_string_literal: true

class Views::Layouts::App < Views::Layouts::Base
  def view_template(&)
    super do
      render partial "partials/header"
      yield
      render partial "partials/footer"
    end
  end
end
