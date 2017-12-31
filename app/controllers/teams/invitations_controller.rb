module Teams
  class InvitationsController < NestedResourcesController
    layout "team"

    def self.resource
      Invitation
    end

    def self.parent_resource
      Team
    end

    def resource_scope
      policy_scope.joins(:user)
    end

    def permitted_params
      [:email, :name, :token, :team_id]
    end

    def assign_attributes
      @invitation.user = current_user
      @invitation.team ||= @team
      @invitation.token ||= Invitation.random_token
    end
  end
end