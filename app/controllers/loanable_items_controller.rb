class LoanableItemsController < Oxidizer::ResourcesController
  include AccountLayout
  def self.resource
    LoanableItem
  end

  protected
    def navigation_key
      "Borrowing"
    end

    def destroy_redirect_url
      @loanable_item.loanable_list
    end

    def destroy_notice
      "Removed from borrowing list"
    end
end
