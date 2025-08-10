class Components::IconComponent < Components::Base
  NOT_FOUND_ICON = "objects".freeze

  def initialize(key, mode: nil, **locals)
    @mode = mode
    @icon = Icon.find(key) || Icon.find(NOT_FOUND_ICON)
    @css_class = locals.fetch(:class, "w-4")
  end

  def view_template
    render Components::VectorComponent.new(asset: @icon.asset, mode: @mode, class: @css_class)
  end
end
