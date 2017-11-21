class TeamsController < ResourcesController
  def self.resource
    Team
  end

  def permitted_params
    [:name]
  end

  def resource_scope
    policy_scope.joins(:user)
  end
end
