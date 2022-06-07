class UsersController < Oxidizer::ResourcesController
  def self.resource
    User
  end

  def permitted_params
    [:name, :email]
  end

  protected

  def resource_scope
    policy_scope
  end
end
