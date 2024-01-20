module ComponentHelper
  def component(name, *args, **kwargs, &block)
    render componentize(name).new(*args, **kwargs), &block
  end

  private
    def componentize(name)
      "#{name.to_s.classify}Component".constantize
    end
end
