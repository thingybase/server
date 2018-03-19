class NotificationsController < ResourcesController
  include TeamLayout

  after_action :notify_members, only: :create

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

  private
    def notify_members
      # TODO: Wire this up in a better place and test to make sure this happens.
      SendNotificationJob.perform_later resource if resource.valid?
    end
end
