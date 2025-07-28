class Components::ListItemsComponent < Components::ListComponent
  def initialize(...)
    super(...)
    @item = -> { render Components::ItemListCardComponent.new(item: _1) }
    @empty = -> { "Containers or items will appear here after they are added" }
  end
end
