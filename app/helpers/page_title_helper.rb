# Helpers for rendering HTML page title attribute and rendering
# common h1, h2 titles.
module PageTitleHelper
  DELIMITER = " · "
  PRODUCT_NAME = "Thingybase"

  def title(title, subtitle: nil)
    provide_page_title title
    build_title_tags title, subtitle
  end

  def provide_page_title(title)
    provide :title, title_tag_text(title)
  end

  def build_title_tags(title, subtitle)
    tags = []
    tags << content_tag(:h1, title, class: "title")
    tags << content_tag(:h2, subtitle, class: "subtitle") if subtitle
    tags.join.html_safe
  end

  def render_page_title
    content_for(:title) || PRODUCT_NAME
  end

  def title_tag_text(title)
    [title, PRODUCT_NAME].join(DELIMITER)
  end
end
