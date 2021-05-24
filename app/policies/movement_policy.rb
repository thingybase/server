class MovementPolicy < ApplicationPolicy
  def new?
    is_user?
  end

  def create?
    is_account_member?
  end

  def update?
    is_account_member?
  end

  def destroy?
    is_account_member?
  end

  def index?
    show?
  end

  class Scope < Scope
    def resolve
      scope.where(account_id: user.accounts)
    end
  end
end
