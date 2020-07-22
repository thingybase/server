class ItemsController < ResourcesController
  include AccountLayout
  include OpenGraphHelper

  before_action :assign_open_graph_image_url, only: :show

  def self.resource
    Item
  end

  private
    def destroy_redirect_url
      @item.parent || account_items_url(@item.account)
    end

    def create_redirect_url
      if @item.container?
        @item
      elsif @item.parent
        @item.parent
      else
        @item
      end
    end

    def permitted_params
      [:name, :account_id, :parent_id, :shelf_life_begin, :shelf_life_end, :container, :icon_key]
    end

    def assign_open_graph_image_url
      self.open_graph_image_url = item_badge_url(@item, format: :png)
    end
end
