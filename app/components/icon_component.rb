class IconComponent < ViewComponent::Base
  NOT_FOUND_ICON = "objects".freeze

  def initialize(key, mode: nil, **locals)
    @mode = mode
    @icon = SvgAsset.find(key) || SvgAsset.find(NOT_FOUND_ICON)
    @css_class = locals[:class]
  end
end
