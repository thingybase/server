class ItemsController < ResourcesController
  include AccountLayout

  def self.resource
    Item
  end

  def destroy_redirect_url
    @item.parent || items_url
  end

  def create_redirect_url
    @item.parent || @item
  end

  def permitted_params
    [:name, :account_id, :parent_id, :shelf_life_begin, :shelf_life_end, :container]
  end
end
