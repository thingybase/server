class ItemsController < Oxidizer::ResourcesController
  include AccountLayout
  include ResourceAnalytics

  before_action :assign_opengraph_attributes, only: :show

  protected
    def navigation_key
      "Items"
    end

  private
    # We want to show these when access is denied for people who are not logged in.
    def deny_opengraph_format
      assign_resource_instance_variable if member_request?
      render layout: "application"
    end

    def destroy_redirect_url
      @item.parent || account_items_url(@item.account)
    end

    def permitted_order_params
      [:name, :created_at, :updated_at]
    end

    def permitted_params
      [:name, :account_id, :parent_id, :expires_at, :container, :icon_key]
    end

    def assign_opengraph_attributes
      opengraph.title = resource.name
    end
end
