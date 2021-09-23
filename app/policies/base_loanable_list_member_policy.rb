# Loanable policy deals with the relationship between a LoanableList
# and its Members.
class BaseLoanableListMemberPolicy < ApplicationPolicy
  def show?
    is_loanable_list_member?
  end

  def index?
    show?
  end

  def create?
    is_account_owner?
  end

  def update?
    is_account_owner?
  end

  def destroy?
    is_account_owner?
  end

  class Scope < Scope
    def resolve
      loanable_lists
    end

    private
      def accounts_scope
        user.accounts
      end

      def user_loanable_lists_scope
        user.loanable_lists
      end

      def account_loanable_lists_scope
        LoanableList.where(account_id: accounts_scope)
      end

      def loanable_lists
        account_loanable_lists_scope.union user_loanable_lists_scope
      end
  end

  private
    def is_loanable_list_member?
      is_user? and is_record_in_scope?
    end
end
