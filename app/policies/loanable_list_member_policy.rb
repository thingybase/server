class LoanableListMemberPolicy < BaseAccountOwnerPolicy
  # Nobody can add a Member directly; it must go through
  # the MemberReviewPolicy to be added.
  def create?
    false
  end

  def update?
    false
  end

  # Only an account owner or the person who is the member can
  # destroy their membership and leave the account.
  def destroy?
    is_owner? or is_account_owner?
  end

  # Other members of the account can see who else is on the account.
  def show?
    is_account_member?
  end

  def index?
    is_account_member?
  end
end
