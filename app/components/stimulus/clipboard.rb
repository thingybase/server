module Components
  class Stimulus::Clipboard < Stimulus::Base
    def source_data
      target_data("source")
    end

    def copy_data
      action_data("copy")
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
