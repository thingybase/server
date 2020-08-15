module AccountsHelper
  def link_to_nav(text, url, **kwargs)
    if navigation_section == text
      classes = kwargs[:class].to_s.split(" ")
      classes << "has-text-weight-bold"
      kwargs[:class] = classes.join(" ")
    end
    link_to text, url, **kwargs
  end
end
