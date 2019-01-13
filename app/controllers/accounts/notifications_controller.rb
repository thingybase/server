module Accounts
  class NotificationsController < NestedResourcesController
    layout "account"

    def self.resource
      Notification
    end

    def self.parent_resource
      Account
    end

    def resource_scope
      policy_scope.includes(:account)
    end

    def permitted_params
      [:subject, :message, :account_id]
    end

    def assign_attributes
      self.resource.user = current_user
      self.resource.account ||= @account
    end
  end
end
