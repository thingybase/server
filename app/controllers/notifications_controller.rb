class NotificationsController < ResourcesController
  include TeamLayout

  def self.resource
    Notification
  end

  def resource_scope
    policy_scope.includes(:team)
  end

  def permitted_params
    [:subject, :message, :team_id]
  end

  def assign_attributes
    self.resource.user = current_user
    self.resource.team ||= @team
  end
end
