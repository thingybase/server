class AcknowledgementPolicy < ApplicationPolicy
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
      scope.joins(:label).where(labels: {account_id: user.accounts})
    end
  end
end
