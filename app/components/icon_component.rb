class IconComponent < ViewComponent::Base
  NOT_FOUND_ICON = "objects".freeze

  def initialize(key, **locals)
    @icon = SvgIconFile.find(key) || SvgIconFile.find(NOT_FOUND_ICON)
    @css_class = locals[:class]
  end
end
