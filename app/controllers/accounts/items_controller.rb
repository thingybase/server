module Accounts
  class ItemsController < NestedResourcesController
    layout "account"

    def self.resource
      Item
    end

    def self.parent_resource
      Account
    end

    def resource_scope
      scope = policy_scope.includes(:account, :container)
      scope = scope.search_by_name(params[:search]) if params.key? :search
      scope
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
