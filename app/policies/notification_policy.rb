class NotificationPolicy < ApplicationPolicy
  def new?
    user.present?
  end

  def create?
    user.present? && is_team_member?
  end

  def update?
    is_owner? || is_team_owner?
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
      user.present? && user == record.team.user
    end

    def is_team_member?
      user.teams.where(id: record.team).exists?
    end
end
