module Items
  class LoanableItemsController < Resourcefully::NestedResourcesController
    include AccountLayout
    before_action :redirect_to_existing_loanable_item, only: :new

    protected
      def self.resource
        LoanableItem
      end

      def self.parent_resource
        Item
      end

      def navigation_key
        "Items"
      end

      def assign_attributes
        @loanable_item.item = @item
        @loanable_item.user = current_user
        @loanable_item.account = @item.account
        @loanable_item.loanable_list ||= @account.loanable_list
      end

      def create_redirect_url
        @loanable_item.loanable_list
      end

    private
      def redirect_to_existing_loanable_item
        redirect_to @item.loanable_item if @item.loanable_item
      end
  end
end
