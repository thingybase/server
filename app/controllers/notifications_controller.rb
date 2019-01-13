class NotificationsController < ResourcesController
  include AccountLayout

  after_action :notify_members, only: :create

  def self.resource
    Notification
  end

  def resource_scope
    policy_scope.includes(:account)
  end

  def permitted_params
    [:subject, :message, :account_id]
  end

  def assign_attributes
    self.resource.user = current_user
    self.resource.account ||= @account
  end

  private
    def notify_members
      # TODO: Wire this up in a better place and test to make sure this happens.
      SendNotificationJob.perform_later @notification if @notification.valid?
    end
end
