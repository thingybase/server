class Components::Field::List < Components::Base
  def block_name = "field"

  def initialize(model)
    @model = model
  end

  def view_template
    yield
  end

  def field(attritube)
    div(class: block_name) {
      render Components::Field.new do
        it.label(class: bem("label", "success")) { @model.class.human_attribute_name(attritube) }
        it.value(class: bem("value", "success")) { @model.send(attritube) }
      end
    }
  end
end
