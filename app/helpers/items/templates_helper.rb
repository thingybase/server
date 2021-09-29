module Items::TemplatesHelper
  def item_template_title(title, item: )
    if item.parent
      title title, subtitle: item_breadcrumb(item.parent), icon: item.parent.icon
    else
      title title, icon: item.icon
    end
  end
end
