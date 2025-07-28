class ListItemsComponent < ListComponent
  def initialize(...)
    super(...)
    @item = -> { render ItemListCardComponent.new(item: _1) }
    @empty = -> { "Containers or items will appear here after they are added" }
  end
end
