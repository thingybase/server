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
        search_scope policy_scope.includes(:account, :container)
      end

      def permitted_params
        [:name, :account_id]
      end

      def assign_attributes
        self.resource.user = current_user
        self.resource.account ||= @account
      end

      def search_scope(scope)
        params[:search].present? ? scope.search_by_name(params[:search]) : scope
      end
  end
end
