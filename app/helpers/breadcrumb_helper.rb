module BreadcrumbHelper
  Link = Struct.new(:text, :url)

  def breadcrumb_link(text, url)
    Link.new(text, url)
  end

  def item_breadcrumb(item = resource, leaf: nil)
    ellipses_link = Link.new "..", item_ancestors_path(item)
    breadcrumb item_breadcrumb_links(item), leaf: leaf, ellipses_link: ellipses_link
  end

  def breadcrumb(*links, leaf: nil, ellipses_link: nil)
    links = links.flatten
    links.append Link.new(leaf) if leaf
    return if links.empty?

    root, *links, active = links
    render partial: "helpers/breadcrumb_helper/breadcrumb", locals: {
        root: root,
        links: links,
        active: active,
        ellipses_link: ellipses_link }
  end

  def item_breadcrumb_links(item=resource)
    item.ancestors.map{ |c| Link.new(c.name, c) }
      .prepend(Link.new(item.name, item))
      .append(Link.new(item.account.name, account_items_path(item.account)))
      .reverse
  end

  def account_breadcrumb_links(account)
    [ Link.new(account.name, account_items_path(account)) ]
  end
end
