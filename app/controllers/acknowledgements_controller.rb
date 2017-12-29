class AcknowledgementsController < ResourcesController
  def self.resource
    Acknowledgement
  end

  def resource_scope
    policy_scope.joins(:user, :notification)
  end

  def permitted_params
    [:notification_id]
  end

  def assign_attributes
    @acknowledgement.notification = @notification
    @acknowledgement.user = current_user
  end
end
