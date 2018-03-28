class ApiKeysController < ResourcesController
  def self.resource
    ApiKey
  end

  def permitted_params
    [:name]
  end

  def assign_attributes
    @api_key.user = current_user
    @api_key.name ||= "#{@api_key.user.name}'s API key created on #{Time.current.to_s(:long)}"
  end

  def resource_scope
    policy_scope.joins(:user)
  end
end
