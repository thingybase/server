module ApplicationHelper
  def render_layout(layout, locals={}, &block)
    render inline: capture(&block), layout: "layouts/#{layout}", locals: locals
  end
end
