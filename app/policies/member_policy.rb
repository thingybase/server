class MemberPolicy < ApplicationPolicy
  def create?
    false
  end

  def new?
    false
  end

  def update?
    false
  end

  def destroy?
    is_owner? || is_account_owner?
  end

  def index?
    show?
  end

  class Scope < Scope
    def resolve
      scope.where(account_id: user.accounts)
    end
  end

  private
    def is_account_owner?
      user.present? && user == record.account&.user
    end
end
