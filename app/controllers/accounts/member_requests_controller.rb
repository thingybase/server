module Accounts
  class MemberRequestsController < Oxidizer::NestedResourcesController
    after_action :deliver_email_notification, only: :create
    before_action :redirect_to_existing_request, only: :create
    skip_before_action :authorize_parent_resource

    protected
      def deliver_email_notification
        return unless resource.persisted?
        MemberRequestMailer.account_request_email(@member_request).deliver_now
      end

      def navigation_key
        "People"
      end

      def access_denied
        redirect_to new_session_url
      end

      def create_notice
        nil
      end

      def redirect_to_existing_request
        member_request = MemberRequest.find_by(user: current_user, account: @account)
        redirect_to member_request if member_request
      end

    private
      def permitted_params
        [:user_id, :account_id]
      end

      def assign_attributes
        resource.account = @account
        resource.user = current_user
      end
  end
end
