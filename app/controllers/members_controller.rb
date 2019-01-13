class MembersController < ResourcesController
  include AccountLayout

  def self.resource
    Member
  end

  def resource_scope
    policy_scope.joins(:user)
  end

  def permitted_params
    [:user_id, :account_id]
  end

  def assign_attributes
    self.resource.account = @account
  end

  def destroy_redirect_url
    account_members_url @account
  end
end
