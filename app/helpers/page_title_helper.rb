# Helpers for rendering HTML page title attribute and rendering
# common h1, h2 titles.
module PageTitleHelper
  DELIMITER = " · "
  PRODUCT_NAME = "Thingybase"

  def title(title, subtitle: nil, icon: nil)
    provide :title, title
    render partial: "page_title_helper/page_header_title", locals: {
      title: title,
      subtitle: subtitle,
      icon: icon
    }
  end

  def render_page_title
    title_tag_text content_for(:title)
  end

  def title_tag_text(title)
    [title, produt_name_title].compact.join(DELIMITER)
  end

  private
    # User agents that we control, like custom apps, should not display the
    # product title because its redudant, so we hide it from the `<title/>` tag.
    def produt_name_title
      PRODUCT_NAME unless is_app?
    end
end
