class Components::List::Base < Components::Base
  def initialize(items)
    @items = items
  end

  def item(&template)
    @item = template
  end

  def empty(...)
    @empty = Components::EmptyList.new(...)
  end

  def view_template(&)
    vanish(&)

    div do
      if @items.empty?
        render @empty
      else
        div do
          @items.each(&@item)
        end
      end
    end
  end
end
