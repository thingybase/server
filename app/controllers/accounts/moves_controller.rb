module Accounts
  class MovesController < Resourcefully::NestedResourceController
    include AccountLayout

    def self.resource
      Move
    end

    def self.parent_resource
      Account
    end

    protected
      def navigation_key
        "Moving"
      end

    private
      def permitted_params
        [:name, :account_id]
      end

      def assign_attributes
        self.resource.user = current_user
        self.resource.account ||= @account
      end
  end
end
