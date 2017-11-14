module ApplicationHelper
  def active_link_to(text, path, **opts)
    opts[:class] = "active" if path == request.path
    link_to text, path, **opts
  end

  def render_layout(layout, locals={}, &block)
    render inline: capture(&block), layout: "layouts/#{layout}", locals: locals
  end
end
