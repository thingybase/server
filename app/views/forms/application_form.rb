class ApplicationForm < Superform::Rails::Form
  def Select(name, *, **, &)
    render field(name).select(*, **, &)
  end

  def Input(name, *, **, &)
    render field(name).input(*, **, &)
  end

  def Submit(*, **, &)
    input(*, type: "submit", **, &)
  end

  def Label(name, *, **, &)
    render field(name).label(*, **, &)
  end

  # include Phlex::Rails::Helpers::Pluralize

  # def row(component)
  #   div do
  #     render component.field.label(style: "display: block;")
  #     render component
  #   end
  # end

  # def around_template(&)
  #   super do
  #     error_messages
  #     yield
  #     submit
  #   end
  # end

  # def error_messages
  #   if model.errors.any?
  #     div(style: "color: red;") do
  #       h2 { "#{pluralize model.errors.count, "error"} prohibited this post from being saved:" }
  #       ul do
  #         model.errors.each do |error|
  #           li { error.full_message }
  #         end
  #       end
  #     end
  #   end
  # end
end
