# frozen_string_literal: true

class Views::App < Views::Base
  def around_template(&)
    super do
      open_graph do |og|
        og.title = title
      end

      render Views::Layouts::App.new(title:) do
        yield
      end
    end
  end

  def title = "Thingybase is rad"
end
