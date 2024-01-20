module ComponentHelper
  def component(name, *args, **kwargs, &block)
    render componentize(name).new(*args, **kwargs), &block
  end

  def components(name, collection, *args, **kwargs, &block)
    collection.map do |item|
      capture { render componentize(name).new(item, *args, **kwargs), &block }
    end.join("\n").html_safe
  end

  private
    def componentize(name)
      "#{name.to_s.classify}Component".constantize
    end
end
