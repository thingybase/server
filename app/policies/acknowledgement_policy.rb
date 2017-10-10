class AcknowledgementPolicy < ApplicationPolicy
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
      scope.joins(:notification).where(notifications: {team_id: user.teams})
    end
  end

  private
    def is_team_member?
      user.teams.where(id: record.notification.team).exists?
    end

    def is_team_owner?
      user.present? && user == record.notification.team.user
    end
end
