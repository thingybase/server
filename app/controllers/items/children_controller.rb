module Items
  class ChildrenController < Oxidizer::NestedResourcesController
    include AccountLayout
    before_action :assign_items, only: [:new, :create]

    def self.resource
      Item
    end

    def self.parent_resource
      Item
    end

    def templates
      authorize parent_resource, :new?
    end

    protected
      def navigation_key
        "Items"
      end

      def assign_items
        @items = @container.children
      end

    private
      def create_notice
        nil
      end

      def create_redirect_url
        url_for action: :new
      end

      def permitted_params
        [:name, :account_id, :parent_id, :container]
      end

      def permitted_order_params
        [:name, :created_at, :updated_at]
      end

      def parent_resource_name
        "container"
      end

      def parent_resource_id_param
        "item_id"
      end

      def nested_resource_scope
        policy_scope parent_resource.children
      end

      def assign_attributes
        resource.user = current_user
        resource.account ||= parent_resource.account
        resource.parent ||= parent_resource
        resource.container ||= created_resource&.container
      end
  end
end
