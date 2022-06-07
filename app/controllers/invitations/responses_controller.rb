module Invitations
  class ResponsesController < Oxidizer::NestedResourcesController
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
        @invitation_response.assign_default :token, params[:token]
        @invitation_response.assign_default :status, "accept"
      end

      def create_redirect_url
        if @invitation_response.accepted?
          @invitation_response.account
        else
          user_url current_user
        end
      end

      def create_notice
        if @invitation_response.accepted?
          "Invitation accepted"
        else
          "Invitation declined"
        end
      end

      def access_denied
        redirect_to new_session_url
      end
  end
end
