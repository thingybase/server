module Accounts
  class MembersController < Oxidizer::NestedResourcesController
    include AccountLayout

    protected
      def navigation_key
        "People"
      end

    private
      def permitted_params
        [:user_id, :account_id]
      end

      def assign_attributes
        self.resource.account = @account
      end

      def destroy_redirect_url
        account_people_url @account
      end
  end
end
