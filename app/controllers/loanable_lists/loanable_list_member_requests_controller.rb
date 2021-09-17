module LoanableLists
  class LoanableListMemberRequestsController < NestedResourcesController
    before_action :redirect_to_existing_request, only: :create

    protected
      def self.resource
        LoanableListMemberRequest
      end

      def self.parent_resource
        LoanableList
      end

      def navigation_key
        "Borrowing"
      end

      def assign_attributes
        @loanable_list_member_request.user = current_user
        @loanable_list_member_request.loanable_list ||= @loanable_list
      end

      def redirect_to_existing_request
        member_request = LoanableListMemberRequest.find_by(user: current_user, loanable_list: @loanable_list)
        redirect_to member_request if member_request
      end
  end
end
