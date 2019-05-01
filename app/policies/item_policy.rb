class ItemPolicy < ApplicationPolicy
  def new?
    user.present?
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

  def duplicate?
    create?
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
      user.present? && user.accounts.where(id: record.account).exists?
    end
end
