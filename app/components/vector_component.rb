class VectorComponent < ViewComponent::Base
  def initialize(key: nil, asset: nil, mode: nil, **locals)
    @mode = mode
    @asset = asset || VectorAsset.collection.find(key)
    @css_class = locals[:class]
  end

  private
    def dark_vector_path(asset, **kwargs)
      vector_path(asset, h: 0, s: 0, l: 100, format: :svg, **kwargs)
    end

    def light_vector_path(asset, **kwargs)
      vector_path(asset, h: 0, s: 0, l: 0, format: :svg, **kwargs)
    end
end
