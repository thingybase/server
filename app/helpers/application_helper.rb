require "set"

module ApplicationHelper
  def active_link_to(text, path, **opts)
    classes = Set.new(opts.fetch(:class, "").split)
    classes << "menu-item"
    classes << "active" if path == request.path
    opts[:class] = classes.to_a.join(" ")
    link_to text, path, **opts
  end

  def render_layout(layout, locals={}, &block)
    render inline: capture(&block), layout: "layouts/#{layout}", locals: locals
  end
end
