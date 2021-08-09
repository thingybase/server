class LoanableListsController < ResourcesController
  include AccountLayout

  def self.resource
    LoanableList
  end

  protected
    def permitted_params
      [:name]
    end

    def navigation_key
      "Borrowing"
    end

    def destroy_redirect_url
      @account
    end
end
