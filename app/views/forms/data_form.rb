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

  class FieldComponent < Components::Base
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

    def label(&content)
      content ||= @label || @field.key.to_s.titleize
      render @field.label(class: "label label-text font-bold text-base") do
        render content
      end
    end

    def field(**)
      render @field.input(class: "input input-bordered", **)
    end

    def hint(&content)
      content ||= @hint
      return unless content

      render @field.label(class: "label label-text opacity-75") do
        render content
      end
    end

    def view_template
      if block_given?
        yield
      else
        label
        field
        hint
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
      @collection = Array(collection)
    end

    def field
      render @field.select(*@collection, class: "select select-bordered")
    end
  end

  class CheckboxFieldComponent < FieldComponent
    class Field < Components::Base
      def initialize(field)
        @field = field
      end

      def checkbox
        render @field.checkbox(class: "checkbox")
      end

      def label(&)
        span(&)
      end

      def view_template
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
