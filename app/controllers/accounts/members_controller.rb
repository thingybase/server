module Accounts
  class MembersController < NestedResourcesController
    include AccountLayout

    def self.resource
      Member
    end

    def self.parent_resource
      Account
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
