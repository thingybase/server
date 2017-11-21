class UsersController < ResourcesController
  def self.resource
    User
  end

  def permitted_params
    [:name, :email]
  end
end
