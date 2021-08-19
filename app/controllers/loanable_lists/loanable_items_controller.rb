module LoanableLists
  class LoanableItemsController < NestedResourcesController
    include AccountLayout

    protected
      def self.resource
        LoanableItem
      end

      def self.parent_resource
        LoanableList
      end

      def navigation_key
        "Borrowing"
      end

      def assign_attributes
        @loanable_item.user = current_user
        @loanable_item.account = @account
        @loanable_item.loanable_list ||= @loanable_list
      end

      def permitted_params
        [:item_id]
      end
  end
end
