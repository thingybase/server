module BreadcrumbHelper
  Link = Struct.new(:text, :url)

  def breadcrumb_link(text, url)
    Link.new(text, url)
  end

  def breadcrumb(*links, leaf: nil)
    links = links.flatten
    links.append Link.new(leaf) if leaf
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

  def account_breadcrumbs(account)
    [ Link.new(account.name, account_items_path(account)) ]
  end
end
