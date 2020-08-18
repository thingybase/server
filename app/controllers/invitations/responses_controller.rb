module Invitations
  class ResponsesController < NestedResourcesController
    rescue_from Pundit::NotAuthorizedError, with: :request_forbidden

    protected
      def self.resource
        InvitationResponse
      end

      def self.parent_resource
        Invitation
      end

      def permitted_params
        [:status, :token]
      end

      def assign_attributes
        @invitation_response.user = current_user
        @invitation_response.invitation = @invitation
        @invitation_response.token ||= params[:token]
        @invitation_response.status ||= "accept"
      end

      def create_redirect_url
        if @invitation_response.accepted?
          @invitation_response.account
        else
          user_url current_user
        end
      end

      def create_notice
        "Successfully added to account" if @invitation_response.accepted?
      end

      def access_denied
        redirect_to new_session_url
      end
  end
end
