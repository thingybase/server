class MemberPolicy < ApplicationPolicy
  def create?
    is_team_owner?
  end

  def new?
    user.present?
  end

  def update?
    is_team_owner?
  end

  def destroy?
    is_owner? || is_team_owner?
  end

  def index?
    show?
  end

  class Scope < Scope
    def resolve
      scope.where(team_id: user.teams)
    end
  end

  private
    def is_team_owner?
      user.present? && user == record.team&.user
    end
end
