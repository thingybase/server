class LoanableListPolicy < BaseLoanablePolicy
  private
    def members_scope
      record.members
    end
end
