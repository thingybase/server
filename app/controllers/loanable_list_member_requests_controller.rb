class LoanableListMemberRequestsController < Resourcefully::ResourcesController
  def self.resource
    LoanableListMemberRequest
  end

  protected
    def navigation_key
      "Borrowing"
    end
end
