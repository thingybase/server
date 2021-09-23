class InvitationResponsePolicy < ApplicationPolicy
  def index?
    false
  end

  def create?
    is_user?
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
