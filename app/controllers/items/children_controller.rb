module Items
  class ChildrenController < NestedResourcesController
    include AccountLayout

    def self.resource
      Item
    end

    def self.parent_resource
      Item
    end

    def templates
      authorize :item, :new?
    end

    protected
      def navigation_key
        "Items"
      end

    private
      def permitted_params
        [:name, :account_id, :parent_id, :container]
      end

      def parent_resource_name
        "item_parent"
      end

      def parent_resource_id_param
        "item_id"
      end

      def nested_resource_scope
        policy_scope parent_resource.children
      end

      def assign_attributes
        self.resource.user = current_user
        self.resource.account ||= parent_resource.account
        self.resource.parent ||= parent_resource
      end
  end
end
