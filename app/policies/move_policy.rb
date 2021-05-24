class MovePolicy < ApplicationPolicy
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

  def index?
    show?
  end

  class Scope < Scope
    def resolve
      scope.where(account_id: user.accounts)
    end
  end
end
