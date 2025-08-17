class Components::Field::List < Components::Base
  def initialize(model)
    @model = model
  end

  def vertical_space = "my-1"
  def horizontal_space = "mx-0"

  def view_template
    yield
  end

  def field(attritube)
    div(class: [vertical_space, horizontal_space]) {
      render Components::Field.new do
        it.label { @model.class.human_attribute_name(attritube) }
        it.value { @model.send(attritube) }
      end
    }
  end
end
