class ItemsController < ResourcesController
  include AccountLayout

  def self.resource
    Item
  end

  def destroy_redirect_url
    if container = @item.container
      container
    else
      items_url
    end
  end

  def permitted_params
    [:name, :account_id, :container_id, :shelf_life_begin, :shelf_life_end]
  end
end
