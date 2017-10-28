class TeamInvitationPolicy < ApplicationPolicy
  def index?
    is_team_owner?
  end

  def new?
    Team.where(user_id: user).exists?
  end

  def create?
    is_team_owner?
  end

  def update?
    is_team_owner?
  end

  def destroy?
    is_team_owner?
  end

  def show?
    is_team_owner? && scope.where(id: record.id).exists?
  end

  class Scope < Scope
    def resolve
      scope.where(team_id: user.teams)
    end
  end

  private
    def is_team_owner?
      user.present? && user == record.team.user
    end
end
