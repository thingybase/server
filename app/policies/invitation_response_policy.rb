class InvitationResponsePolicy < ApplicationPolicy
  def index?
    false
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
