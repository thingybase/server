class LoanableItemPolicy < BaseLoanableListMemberPolicy
  class Scope < Scope
    def resolve
      # require "pry"
      # binding.pry
      scope.where(loanable_list: loanable_lists)
    end
  end
end
