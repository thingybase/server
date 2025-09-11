# frozen_string_literal: true

class Components::Field < Components::Base
  def view_template
    div(class: "flex flex-row gap-8") {
      yield
    }
  end

  def value(class: "font-italic", **, &)
    div(class:, &)
  end

  def label(class: "font-bold", **)
    super(class:, **)
  end
end
