class TeamsController < ResourcesController
  layout "team", except: %i[index new]

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
