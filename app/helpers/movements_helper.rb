module MovementsHelper
  # Any item can be selected to move, but lets remove items
  # already moved so its easier.
  def origin_select_items(move:)
    items = account_policy_scope(Item)
    items = items.where.not(id: move.items)
    item_select_values(items)
  end

  # Destinations have to be a container..
  def destination_select_items
    item_select_values(account_policy_scope(Item.container))
  end
end
