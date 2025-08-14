class Components::List::ItemsComponent < Components::List::Component
  def initialize(...)
    super(...)
    @item = -> { render Components::List::ItemCardComponent.new(item: _1) }
    @empty = -> { "Containers or items will appear here after they are added" }
  end
end
