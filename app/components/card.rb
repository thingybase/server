class Components::Card < Components::Base
  def around_template
    super do
      div(class: "card p-4 rounded-xl shadow-lg") do
        yield # Renders the `view_template`
      end
    end
  end

  def view_template
    div do
      yield if block_given?
    end
  end
end
