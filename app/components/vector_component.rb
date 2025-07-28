class Components::VectorComponent < Components::Base
  def initialize(key: nil, asset: nil, mode: nil, alt: nil, **locals)
    @mode = mode
    @asset = asset || VectorAsset.collection.find(key)
    @css_class = locals[:class]
    @alt ||= @asset.name
  end

  def view_template
    picture(class: "inline-block") do
      case @mode
      when nil
        source(media: "(prefers-color-scheme: dark)", srcset: dark_vector_path(@asset, format: :svg))
        image_tag light_vector_path(@asset, format: :svg), alt: @alt, class: @css_class
      when :dark
        image_tag dark_vector_path(@asset, format: :svg), alt: @alt, class: @css_class
      when :light
        image_tag light_vector_path(@asset, format: :svg), alt: @alt, class: @css_class
      end
    end
  end

  private

  def dark_vector_path(asset, **kwargs)
    vector_path(asset, h: 0, s: 0, l: 100, format: :svg, **kwargs)
  end

  def light_vector_path(asset, **kwargs)
    vector_path(asset, h: 0, s: 0, l: 0, format: :svg, **kwargs)
  end
end
