module Accounts
  class PeopleController < ApplicationController
    include AccountLayout

    def index
      authorize @account, :show?
      @members = policy_scope(Member).where(account: @account)
      @invitations = policy_scope(Invitation).where(account: @account)
    end

    private
      def navigation_section
        "People"
      end

      def find_account
        Account.find_resource params[:account_id]
      end
  end
end
