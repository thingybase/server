module PagesHelper
  def link_to_page(page, active_class: nil, **kwargs)
    page = coerce_page(page)

    if page == current_page && active_class.present?
      kwargs[:class] = kwargs[:class].to_s.split(" ").append(active_class).join(" ")
    end

    link_to page.data.fetch("title"), page.request_path, **kwargs
  end

  def background_image_style(url: current_page.data.fetch("image_url"))
    "background-image: url(#{url}); background-position: center center; background-size: cover; background-attachment: fixed;"
  end

  private
    def coerce_page(value)
      case value
      when String
        Sitepress.site.get(value)
      else
        value
      end
    end
end
