# frozen_string_literal: true

class Components::Stats < Components::Base
  class Stat < Components::Base
    def view_template
      div(class: "stat"){
        yield
      }
    end

    def title(&)
      div(class: "stat-title text-primary-content", &)
    end

    def value(&)
      div(class: "stat-value", &)
    end
  end

  def view_template
    div(class: "stats bg-primary text-primary-content md:col-span-3 text-center"){
      yield
    }
  end

  def stat(*, **, &)
    render(Stat.new(*, **), &)
  end
  alias :add :stat
end
