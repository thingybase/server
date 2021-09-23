# Random users from the Internet can request to join an account or other
# resource usually via a Memberships type of table. This policy lets a user
# create a Request.
class BaseUserRequestPolicy < BaseAccountOwnerPolicy
  # Only the user can initiate the request; account owners cannot.
  def create?
    is_user?
  end

  def new?
    is_user?
  end

  # The person who created the request or the account owner
  # can destroy or show the request.
  def destroy?
    is_owner? or is_account_owner?
  end

  def show?
    is_owner? or is_account_owner?
  end
end
