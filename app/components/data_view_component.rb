class Components::DataViewComponent < Components::Base
  def initialize(model)
    @model = model
  end

  def view_template
    div(class: "grid grid-cols-2 gap-4") do
      yield
    end
  end

  def field(key, &content)
    div(class: "font-bold") { key.to_s.humanize }
    if content
      render content
    else
      div(class: "w-max") { @model.send(key).to_s }
    end
  end
end
