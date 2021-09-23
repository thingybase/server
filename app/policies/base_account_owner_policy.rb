# Actions may only be authorized for an account owner. This is
# mostly useful for very sensitive parts of the app where a high
# level of priledge is needed to add users to an account or share
# stuff to the public.
class BaseAccountOwnerPolicy < ApplicationPolicy
  def new?
    Account.where(user_id: user).exists?
  end

  def index?
    is_account_owner?
  end

  def create?
    is_account_owner?
  end

  def update?
    is_account_owner?
  end

  def destroy?
    is_account_owner?
  end

  def show?
    is_account_owner? and is_record_in_scope?
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
