module Components
  class Stimulus::Base < Components::Base
    def around_template
      super do
        div(data: { controller: name }) do
          yield
        end
      end
    end

    def target_data(target)
      { data: { target: "#{name}.#{target}" } }
    end

    def action_data(action)
      { data: { action: "#{name}##{action}" } }
    end

    def name = self.class.name.demodulize.underscore
  end
end
