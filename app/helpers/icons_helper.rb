module IconsHelper
  def render_icon(key, **locals)
    locals[:dark_path] = dark_icon_path(key, format: :svg)
    locals[:light_path] = light_icon_path(key, format: :svg)
    locals[:css_class] = locals[:class]
    render partial: "icons_helper/darkmode_icons", locals: locals
  end
end
