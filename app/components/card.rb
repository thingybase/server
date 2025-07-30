class Components::Card < Components::Base
  class Text < self
    def around_template(&)
      super do
        body(&) # Renders the `view_template`
      end
    end
  end

  def initialize(class: "bg-base-200 md:col-span-2")
    @class = binding.local_variable_get("class")
  end

  def around_template
    super do
      div(class: ["card", @class]) do
        yield # Renders the `view_template`
      end
    end
  end

  def body
    div(class: "card-body") do
      yield # Renders the `view_template`
    end
  end

  class Header < Components::Base
    def view_template(&)
      hgroup(&)
    end

    def title(&)
      h3(class: "card-title", &)
    end

    def subtitle(&)
      h4(class: "font-semibold", &)
    end
  end

  def header(&)
    render Header.new(&)
  end

  def view_template
    yield if block_given?
  end
end
