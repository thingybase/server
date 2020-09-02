module Accounts
  class PeopleController < ApplicationController
    include AccountLayout

    def index
      authorize @account, :edit?
      @members = policy_scope(Member).where(account: @account)
      @invitations = policy_scope(Invitation).where(account: @account)
      @member_requests = policy_scope(MemberRequest).where(account: @account)
    end

    def new
      authorize @account, :edit?
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
