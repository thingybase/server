class TeamInvitationResponsesController < ResourcesController
  def self.resource
    TeamInvitationResponse
  end

  def permitted_params
    [:status, :token]
  end

  def edit
    @team_invitation_response.token = params[:token]
    @team_invitation_response.status = "accept"
  end

  def update_redirect_url
    @team_invitation_response.team
  end
end
