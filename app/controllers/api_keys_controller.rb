class ApiKeysController < ResourcesController
  def self.resource
    ApiKey
  end

  def permitted_params
    [:name]
  end

  def resource_scope
    policy_scope.joins(:user)
  end
end
