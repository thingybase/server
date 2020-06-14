module BreadcrumbHelper
  Link = Struct.new(:text, :url)

  def breadcrumb(links = [])
    return if links.empty?

    root, *links, active = links
    render partial: "helpers/breadcrumb_helper/breadcrumb", locals: { root: root, links: links, active: active }
  end

  def item_breadcrumbs(item=resource)
    item.ancestors.map{ |c| Link.new(c.name, c) }
      .prepend(Link.new(item.name, item))
      .append(Link.new(item.account.name, account_items_path(item.account)))
      .reverse
  end

  def label_breadcrumbs(label=resource)
    return [] unless label.item
    links = item_breadcrumbs(label.item)
    links.append Link.new("Label", label)
  end
end
