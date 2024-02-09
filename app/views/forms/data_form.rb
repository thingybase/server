class DataForm < ApplicationForm
  def Field(name, *, **, &)
    render FieldComponent.new(field(name), *, **, &)
  end

  def TextField(name, *, **, &)
    render TextFieldComponent.new(field(name), *, **), &
  end

  def SelectField(name, *, **, &)
    render SelectFieldComponent.new(field(name), *, **), &
  end

  def CheckboxField(name, *, **, &)
    render CheckboxFieldComponent.new(field(name), *, **), &
  end

  def Submit(*, **, &)
    super(*, class: "btn btn-primary", **, &)
  end

  class FieldComponent < ApplicationComponent
    def initialize(field, label: nil, hint: nil)
      @field = field
      @label = label
      @hint = hint
    end

    def around_template(&)
      div class: "form-control" do
        yield
      end
    end

    def label(&)
      render @field.label(class: "label label-text font-bold", &)
    end

    def field(**)
      render @field.input(class: "input input-bordered", **)
    end

    def hint(&)
      div(class: "opacity-75", &)
    end

    def template
      if block_given?
        yield
      else
        label { @label }
        field
        hint { @hint }
      end
    end
  end

  class TextFieldComponent < FieldComponent
    def field(**)
      render @field.input(class: "input input-bordered", type: :text, **)
    end
  end

  class SelectFieldComponent < FieldComponent
    def initialize(field, collection, *, **)
      super(field, *, **)
      @collection = collection
    end

    def field
      render @field.select(@collection, class: "select select-bordered")
    end
  end

  class CheckboxFieldComponent < FieldComponent
    class Field < ApplicationComponent
      def initialize(field)
        @field = field
      end

      def checkbox
        render @field.input(type: :checkbox, class: "checkbox")
      end

      def label(&)
        span(&)
      end

      def template
        render @field.label class: "flex flex-row gap-2" do
          yield
        end
      end
    end

    def field(&input)
      if block_given?
        render Field.new(@field), &input
      else
        render @field.input(type: :checkbox, class: "checkbox")
      end
    end
  end

  def around_template(&form)
    super do
      div class: "flex flex-col gap-4", &form
    end
  end
end