module Notifications
  class AcknowledgementsController < NestedResourcesController
    def self.resource
      Acknowledgement
    end

    def self.parent_resource
      Notification
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
end