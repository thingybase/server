class LoanableListPolicy < BaseLoanableListMemberPolicy
  private
    def members_scope
      record.members
    end
end
