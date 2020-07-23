# Deals with open graph meta tags by getting data from controller into the view.
module OpenGraphHelper
  def open_graph_title=(title)
    @open_graph_title = title
  end

  def open_graph_image_url=(url)
    @open_graph_image_url = url
  end

  def open_graph_meta_tags
    render partial: "open_graph_helper/meta_tags", locals: {
      open_graph_image_url: @open_graph_image_url,
      open_graph_title: open_graph_title,
      open_graph_site_name: PageTitleHelper::PRODUCT_NAME
    }
  end

  protected
    def open_graph_title
      @open_graph_title ||= content_for(:title)
    end
end
