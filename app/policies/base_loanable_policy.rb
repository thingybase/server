class BaseLoanablePolicy < ApplicationPolicy
  def show?
    is_account_member? or is_loanable_list_member?
  end

  def index?
    show?
  end

  def new?
    is_account_owner?
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

  private
    def is_loanable_list_member?
      is_user? && members_scope.where(user: user).exists?
    end

    def members_scope
      raise NotImplementedError
    end
end
