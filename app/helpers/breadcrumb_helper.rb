module BreadcrumbHelper
  Link = Struct.new(:text, :url)

  def breadcrumb(links = [], text: nil)
    return if links.empty?

    root, *links, active = links
    render partial: "helpers/breadcrumb_helper/breadcrumb", locals: { root: root, links: links, active: active }
  end

  def container_breadcrumbs(container=resource)
    container.ancestors.map{ |c| Link.new(c.name, c) }
      .append(Link.new(container.name, container))
      .prepend(Link.new(@account.name, account_containers_path(@account)))
  end

  def item_breadcrumbs(item=resource)
    if item.container
      container_breadcrumbs(item.container).append Link.new(item.name, item)
    else
      []
    end
  end

  def label_breadcrumbs(label=resource)
    return [] unless label.labelable

    links = case label.labelable
    when Item
      item_breadcrumbs(label.labelable)
    when Container
      container_breadcrumbs(label.labelable)
    end

    links.append Link.new("Label", label)
  end
end
