class MemberReviewPolicy < ApplicationPolicy
  def update?
    is_account_owner?
  end

  def destroy?
    is_account_owner?
  end

  def index?
    is_account_owner?
  end

  def show?
    is_account_owner?
  end

  def create?
    is_account_owner?
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
