module Accounts
  class LoanableListsController < Oxidizer::NestedResourceController
    include AccountLayout

    def self.resource
      LoanableList
    end

    def self.parent_resource
      Account
    end

    def show
      redirect_to resource || url_for(action: :new)
    end

    protected
      def navigation_key
        "Borrowing"
      end

    private
      def permitted_params
        [:name, :account_id]
      end

      def assign_attributes
        resource.user = current_user
        resource.account ||= @account
        resource.name ||= "#{current_user.name}'s Stuff"
      end
  end
end
