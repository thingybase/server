class InvitationResponsePolicy < ApplicationPolicy
  def index?
    false
  end

  def new?
    true
  end

  def create?
    user.present?
  end

  def update?
    false
  end

  def destroy?
    false
  end

  def show?
    false
  end
end
