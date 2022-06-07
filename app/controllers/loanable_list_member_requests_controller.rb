class LoanableListMemberRequestsController < Oxidizer::ResourcesController
  def self.resource
    LoanableListMemberRequest
  end

  protected
    def navigation_key
      "Borrowing"
    end
end
