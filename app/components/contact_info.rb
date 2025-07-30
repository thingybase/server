# frozen_string_literal: true

class Components::ContactInfo < Components::Base
  class Title < Components::Base
    def title(&)
      h1(class: "text-2xl font-bold", &)
    end

    def subtitle(&)
      h2(class: "text-lg", &)
    end

    def around_template(&)
      super do
        hgroup(&)
      end
    end
  end

  def initialize(user, *, **, &)
    super(*, **, &)
    @user = user
    @list = List.new
  end

  class List < Components::Base
    def view_template
      dl do
        yield if block_given?
      end
    end

    def item(label, &value)
      dt(class: "font-bold mt-4") { label }
      dd(&value)
    end
  end

  def item(label, &value)
    @list.item(label, &value)
  end

  def view_template(&)
    render Title.new do |title|
      title.title { @user.name }
      title.subtitle { "Contact Card" }
    end

    yield
  end

  def around_template(&)
    Components::Card(&)
  end
end
