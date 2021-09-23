module Borrowing
  class LoanableItemPolicy < ContextPolicy
    class Scope < ApplicationPolicy::Scope
      def resolve
        scope.joins(loanable_list: :members).where loanable_list_members: { user: user }
      end
    end
  end
end
