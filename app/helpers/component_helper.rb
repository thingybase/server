module ComponentHelper
  def component(name, *args, **kwargs, &block)
    render componentize(name).new(*args, **kwargs), &block
  end

  private
    def componentize(name)
      "Components::#{name.to_s.classify}Component".constantize
    end
end
