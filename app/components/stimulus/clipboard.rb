module Components
  class Stimulus::Clipboard < Components::Base
    def around_template
      super do
        div(data: { controller: "clipboard" }) do
          yield
        end
      end
    end

    def source_data
      { data: { target: "clipboard.source" } }
    end

    def copy_data
      { data: { action: "clipboard#copy" } }
    end

    def textarea(**attributes, &)
      super(**attributes.merge(source_data), &)
    end

    def button(**attributes, &)
      super(**attributes.merge(copy_data), &)
    end

    def input(**attributes, &)
      super(**attributes.merge(source_data), &)
    end
  end
end
