class Components::List::Items < Components::List::Base
  def initialize(...)
    super(...)
    @item = -> { render Components::List::ItemCard.new(item: _1) }
    @empty = -> { "Containers or items will appear here after they are added" }
  end
end
