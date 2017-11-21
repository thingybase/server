class AcknowledgementsController < ResourcesController
  before_action :set_notification, only: [:new]

  def self.resource
    Acknowledgements
  end

  def permitted_params
    [:notification_id]
  end

  def resource_scope
    policy_scope.joins(:user, :notification)
  end

  def before_new
    @acknowledgement.notification = @notification
    @acknowledgement.user = current_user
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_notification
      @notification = Notification.find(params[:notification_id]) if params.key?(:notification_id)
    end
end
