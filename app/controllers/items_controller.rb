class ItemsController < ResourcesController
  include AccountLayout
  include OpenGraphHelper

  before_action :assign_open_graph_attributes, only: :show

  def self.resource
    Item
  end

  protected
    def navigation_section
      "Items"
    end

  private
    # We want to show these when access is denied for people who are not logged in.
    def access_denied
      assign_open_graph_attributes
      super
    end

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
      [:name, :account_id, :parent_id, :shelved_at, :expires_at, :container, :icon_key]
    end

    def assign_open_graph_attributes
      self.open_graph_image_url = item_badge_url(resource, format: :png)
      self.open_graph_title = resource.name
    end
end
