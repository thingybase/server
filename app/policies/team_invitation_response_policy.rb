class TeamInvitationResponsePolicy < ApplicationPolicy
  def index?
    false
  end

  def new?
    false
  end

  def create?
    false
  end

  def update?
    user.present?
  end

  def destroy?
    false
  end

  def show?
    false
  end
end
