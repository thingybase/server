module Components
  class Form < Superform::Rails::Form
    include Phlex::Rails::Helpers::Pluralize

    class Field < self::Field
      def input(class: nil, **)
        super(class: ["input input-bordered", grab(class:)], **)
      end

      def label(class: "font-bold", **)
        super(class:, **)
      end

      # Useful for mixing the `class` parameter into super method calls
     	private def grab(**bindings)
    		if bindings.size > 1
    			bindings.values
    		else
    			bindings.values.first
    		end
    	end
    end

    def row(component)
      div(class: "flex flex-col gap-1 mb-6") do
        render component.field.label
        render component
      end
    end

    def around_template(&)
      super do
        error_messages
        yield if block_given?
      end
    end

    def error_messages
      if model.errors.any?
        div(style: "color: red;") do
          h2 { "#{pluralize model.errors.count, "error"} prohibited this post from being saved:" }
          ul do
            model.errors.each do |error|
              li { error.full_message }
            end
          end
        end
      end
    end
  end
end
