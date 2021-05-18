module MarkdownHelper
  def markdown_image(link, title, alt_text)
    url = URI(link)
    if url.scheme == "vector"
      path = Pathname.new(url.path).relative_path_from("/").to_s
      render VectorComponent.new(key: path)
    else
      image_tag link, alt: alt_text, title: title
    end
  end
end
