class IconComponent < ViewComponent::Base
  NOT_FOUND_ICON = "objects".freeze

  def initialize(key, mode: nil, **locals)
    @mode = mode
    @icon = Icon.find(key) || Icon.find(NOT_FOUND_ICON)
    @css_class = locals[:class]
  end

  def call
    render VectorComponent.new(asset: @icon.asset, mode: @mode, class: @css_class)
  end
end
