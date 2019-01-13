class AccountPolicy < ApplicationPolicy
  class Scope < Scope
    # TODO: This is super-wonky because I don't create a `member` record
    # for an owner. I should probably do that and then clean up this query.
    # For now this works, but its pretty meh.
    def resolve
      scope
        .joins("LEFT JOIN members ON members.account_id = accounts.id")
        .where("members.user_id = ? OR accounts.user_id = ?", @user.id, @user.id)
        .distinct
    end
  end
end
