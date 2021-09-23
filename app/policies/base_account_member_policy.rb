# Authorizes people who are a member of accounts to perform
# basic CRUD actions on account resources.
class BaseAccountMemberPolicy < ApplicationPolicy
  def new?
    is_account_member?
  end

  def create?
    is_account_member?
  end

  def update?
    is_account_member?
  end

  def destroy?
    is_account_member?
  end

  def index?
    show?
  end

  class Scope < Scope
    def resolve
      scope.where(account_id: accounts_scope)
    end

    private
      def accounts_scope
        user.accounts
      end
  end
end
