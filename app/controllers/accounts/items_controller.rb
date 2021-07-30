module Accounts
  class ItemsController < NestedResourcesController
    include AccountLayout
    before_action :assign_items, only: :new

    def self.resource
      Item
    end

    def self.parent_resource
      Account
    end

    def templates
      authorize :item, :new?
    end

    protected
      def navigation_key
        "Items"
      end

      def assign_items
        @items = resources.roots
      end

    private

      def resource_scope
        policy_scope.includes(:account).order(:name)
      end

      def permitted_params
        [:name, :account_id, :container]
      end

      def assign_attributes
        self.resource.user = current_user
        self.resource.account ||= @account
      end
  end
end
