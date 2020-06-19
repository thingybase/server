module IconsHelper
  def render_icon(key, **locals)
    icon = SvgIconFile.find(key)
    locals[:dark_path] = dark_icon_path(icon, format: :svg)
    locals[:light_path] = light_icon_path(icon, format: :svg)
    locals[:css_class] = locals[:class]
    locals[:name] = icon.name
    render partial: "icons_helper/darkmode_icons", locals: locals
  end

  def icon_select_values(scope: SvgIconFile.all)
    scope.map { |icon| [ icon.name, icon.key ] }
  end
end
