class ItemsController < Oxidizer::ResourcesController
  include AccountLayout
  include ResourceAnalytics
  include Superview::Actions

  before_action :assign_opengraph_attributes, only: :show

  def phlex
    super.tap do |view|
      view.account = @account
      view.user = current_user
    end
  end

  class Show < AccountLayout::Component
    attr_writer :item

    def title = @item.name
    def icon = @item.icon
    def subtitle
      div(class: "breadcrumbs") do
        ul do
          @item.parent do |item|
            li { show(item, :name) }
          end
          li { show(@account, :name) }
        end
      end
    end
  end

  class Contanier < Show
    def template
    end
  end

  class Item < Show
    def template
    end
  end

  def show
    view_class = @item.container? ? Container : Item
    view = assign_phlex_accessors(view_class.new)
    view.user = current_user

    render assign_phlex_accessors(view), layout: false
  end

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
