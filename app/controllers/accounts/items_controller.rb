module Accounts
  class ItemsController < NestedResourcesController
    include AccountLayout

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
      def navigation_section
        "Items"
      end

    private
      def create_redirect_url
        if @item.container?
          @item
        elsif @item.parent
          @item.parent
        else
          @item
        end
      end

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
