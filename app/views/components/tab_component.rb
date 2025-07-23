class TabComponent < ApplicationComponent
  def initialize(path: nil, **attributes)
    @path = path
    @attributes = attributes
  end

  def view_template
    ul(class: tokens("tabs", @attributes[:class])) do
      yield
    end
  end

  def tab(path, **attributes, &content)
    active_class = "tab-active" if path == active_path

    li(class: tokens("tab", active_class, attributes.delete(:class)), **attributes) do
      link_to(path, "data-turbolinks-action": "replace", &content)
    end
  end

  def active_path
    @path || helpers.request.path
  end
end
