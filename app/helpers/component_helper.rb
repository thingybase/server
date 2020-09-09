module ComponentHelper
  def component(*args, **kwargs, &block)
    render componentize(*args, **kwargs, &block)
  end

  private
    def componentize(name, *args, **kwargs, &block)
      "#{name.to_s.classify}Component".constantize.new(*args, **kwargs, &block)
    end
end
