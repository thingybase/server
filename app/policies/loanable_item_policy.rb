class LoanableItemPolicy < BaseLoanablePolicy
  private
    def members_scope
      record.loanable_list.members
    end
end
