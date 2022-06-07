module LoanableLists
  class LoanableListMembersController < Oxidizer::NestedResourcesController
    include AccountLayout

    protected
      def self.resource
        LoanableListMember
      end

      def self.parent_resource
        LoanableList
      end

      def navigation_key
        "Borrowing"
      end

      def assign_attributes
        @loanable_list_member.user = current_user
        @loanable_list_member.loanable_list ||= @loanable_list
      end
  end
end
