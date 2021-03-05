class ApplicationMarkdownRenderer < Redcarpet::Render::HTML
  # include ActionController::Base.helpers
  # def block_quote(quote)
  #   %(<blockquote class="my-custom-class">#{quote}</blockquote>)
  # end

  def image(link, title, alt_text)
    url = URI(link)
    if url.scheme == "vector"
      path = Pathname.new(url.path).relative_path_from("/").to_s
      VectorComponent.new(key: path).render_in ApplicationController.helpers
    else
      ActionController::Base.helpers.image_tag link, alt: alt_text, title: title
    end
  end
end

markdown = Redcarpet::Markdown.new(ApplicationMarkdownRenderer,
  fenced_code_blocks: true,
  autolink: true)

MarkdownRails.configure do |config|
  config.render do |markdown_source|
    markdown.render(markdown_source)
  end
end
