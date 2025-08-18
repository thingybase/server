# frozen_string_literal: true

class Views::App < Views::Layouts::Base
  def around_template(&)
    super do
      render Views::Layouts::App.new(title:) do
        yield
      end
    end
  end

  def title = "Thingybase"
end
