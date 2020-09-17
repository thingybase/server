module PagesHelper
  def link_to_page(page, active_class: nil, **kwargs)
    if page == current_page && active_class.present?
      kwargs[:class] = kwargs[:class].to_s.split(" ").append(active_class).join(" ")
    end
    link_to page.data.fetch("title"), page.request_path, **kwargs
  end
end
