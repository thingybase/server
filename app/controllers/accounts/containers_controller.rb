module Accounts
  class ContainersController < NestedResourcesController
    layout "account"

    def self.resource
      Container
    end

    def self.parent_resource
      Account
    end

    def resource_scope
      policy_scope.roots.includes(:account)
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
