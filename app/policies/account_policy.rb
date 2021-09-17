class AccountPolicy < ApplicationPolicy
  def show?
    is_account_member?
  end

  class Scope < Scope
    def resolve
      @user.accounts
    end
  end

  private
    def account
      record
    end
end
