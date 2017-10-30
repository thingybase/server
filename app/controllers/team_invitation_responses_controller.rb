class TeamInvitationResponsesController < ApplicationController
  skip_after_action :verify_authorized
  before_action :set_team_invitation
  before_action :set_team_invitation_response

  # GET /team_invitation_responses/1
  # GET /team_invitation_responses/1.json
  def edit
    @team_invitation_response.status = "accept"
  end

  # POST /team_invitation_responses
  # POST /team_invitation_responses.json
  def update
    @team_invitation_response.assign_attributes(team_invitation_response_params)

    respond_to do |format|
      if @team_invitation_response.save
        format.html { redirect_to @team_invitation_response.invitation.team, notice: 'Team invitation response was successfully recorded.' }
        format.json { render :show, status: :created, location: @team_invitation_response.invitation.team }
      else
        format.html { render :edit }
        format.json { render json: @team_invitation_response.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def set_team_invitation
      @team_invitation = TeamInvitation.find_by_token!(params[:token])
    end

    def set_team_invitation_response
      @team_invitation_response = TeamInvitationResponse.new
      @team_invitation_response.invitation = @team_invitation
      @team_invitation_response.user = current_user
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def team_invitation_response_params
      params.require(:team_invitation_response).permit(:status)
    end
end
