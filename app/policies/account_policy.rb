class AccountPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      @user.accounts
    end
  end
end
