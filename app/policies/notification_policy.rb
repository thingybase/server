class NotificationPolicy < ApplicationPolicy
  def new?
    user.present?
  end

  def create?
    user.present? && is_account_member?
  end

  def update?
    is_owner? || is_account_owner?
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
      user.present? && user == record.account.user
    end

    def is_account_member?
      user.accounts.where(id: record.account).exists?
    end
end
