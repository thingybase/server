class TeamPolicy < ApplicationPolicy
  def create?
    user.present?
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    # TODO: This is super-wonky because I don't create a `member` record
    # for an owner. I should probably do that and then clean up this query.
    # For now this works, but its pretty meh.
    def resolve
      scope
        .joins("LEFT JOIN members ON members.team_id = teams.id")
        .where("members.user_id = ? OR teams.user_id = ?", @user.id, @user.id)
        .distinct
    end
  end
end
