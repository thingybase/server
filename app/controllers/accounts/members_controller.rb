module Accounts
  class MembersController < ResourcesController
    include AccountLayout

    def self.resource
      Member
    end

    def self.parent_resource
      Account
    end

    def resource_scope
      policy_scope.joins(:user).where(account: @account)
    end

    def permitted_params
      [:user_id, :account_id]
    end

    def assign_attributes
      self.resource.account = @account
    end

    def destroy_redirect_url
      account_members_url @account
    end
  end
end
