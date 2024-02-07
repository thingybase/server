class ListComponent < ApplicationComponent
  include Phlex::DeferredRender

  def initialize(items)
    @items = items
  end

  def item(&template)
    @item = template
  end

  def empty(...)
    @empty = EmptyListComponent.new(...)
  end

  def template
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
