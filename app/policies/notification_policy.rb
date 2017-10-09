class NotificationPolicy < ApplicationPolicy
  def create?
    is_owner? || is_team_owner?
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
    # TODO: This is super-wonky because I don't create a `member` record
    # for an owner. I should probably do that and then clean up this query.
    # For now this works, but its pretty meh.
    def resolve
      scope
        .joins("LEFT JOIN teams ON teams.id = notifications.team_id")
        .where("notifications.user_id = ? OR teams.user_id = ?", @user.id, @user.id)
        .distinct
    end
  end

  private
    def is_team_owner?
      user.present? && user == record.team.user
    end
end
