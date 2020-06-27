module Accounts
  class ItemsController < NestedResourcesController
    layout "account"

    def self.resource
      Item
    end

    def self.parent_resource
      Account
    end

    private
      def resource_scope
        policy_scope.roots.includes(:account).container_then_item
      end

      def permitted_params
        [:name, :account_id]
      end

      def assign_attributes
        self.resource.user = current_user
        self.resource.account ||= @account
      end
  end
end
