# Helpers for rendering HTML page title attribute and rendering
# common h1, h2 titles.
module PageTitleHelper
  DELIMITER = " · "
  PRODUCT_NAME = "Thingybase"

  def title(title, subtitle: nil, icon: nil)
    provide_page_title title
    render partial: "page_title_helper/page_header_title", locals: {
      title: title,
      subtitle: subtitle,
      icon: icon
    }
  end

  def provide_page_title(title)
    provide :title, title_tag_text(title)
  end

  def render_page_title
    content_for(:title) || PRODUCT_NAME
  end

  def title_tag_text(title)
    [title, PRODUCT_NAME].join(DELIMITER)
  end
end
