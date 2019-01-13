class InvitationPolicy < ApplicationPolicy
  def index?
    is_account_owner?
  end

  def new?
    Account.where(user_id: user).exists?
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

  def show?
    is_account_owner? && scope.where(id: record.id).exists?
  end

  def email?
    is_account_owner?
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
end
