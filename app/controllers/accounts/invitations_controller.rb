module Accounts
  class InvitationsController < NestedResourcesController
    include AccountLayout

    protected
      def navigation_key
        "People"
      end

    private
      def create_notice
        nil
      end

      def self.resource
        Invitation
      end

      def self.parent_resource
        Account
      end

      def resource_scope
        policy_scope.joins(:user)
      end

      def permitted_params
        [:email, :name, :token, :account_id]
      end

      def assign_attributes
        @invitation.user = current_user
        @invitation.account ||= @account
        @invitation.token ||= Invitation.random_token
      end
  end
end