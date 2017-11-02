class TeamInvitationsController < ApplicationController
  before_action :set_team_invitation, only: [:show, :edit, :update, :destroy]
  before_action :authorize_team_invitation, only: [:show, :edit, :destroy]

  # GET /team_invitations
  # GET /team_invitations.json
  def index
    @team_invitations = policy_scope(TeamInvitation)
  end

  # GET /team_invitations/1
  # GET /team_invitations/1.json
  def show
  end

  # GET /team_invitations/new
  def new
    @team_invitation = TeamInvitation.new
    @team_invitation.user = current_user
    @team_invitation.token = TeamInvitation.random_token
    authorize_team_invitation
  end

  # GET /team_invitations/1/edit
  def edit
  end

  # POST /team_invitations
  # POST /team_invitations.json
  def create
    @team_invitation = TeamInvitation.new(team_invitation_params)
    @team_invitation.user = current_user
    authorize_team_invitation

    respond_to do |format|
      if @team_invitation.save!
        format.html { redirect_to @team_invitation, notice: 'Team invitation was successfully created.' }
        format.json { render :show, status: :created, location: @team_invitation }
      else
        format.html { render :new }
        format.json { render json: @team_invitation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /team_invitations/1
  # PATCH/PUT /team_invitations/1.json
  def update
    @team_invitation.assign_attributes(team_invitation_params)
    authorize_team_invitation

    respond_to do |format|
      if @team_invitation.save
        format.html { redirect_to @team_invitation, notice: 'Team invitation was successfully updated.' }
        format.json { render :show, status: :ok, location: @team_invitation }
      else
        format.html { render :edit }
        format.json { render json: @team_invitation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /team_invitations/1
  # DELETE /team_invitations/1.json
  def destroy
    @team_invitation.destroy
    respond_to do |format|
      format.html { redirect_to team_invitations_url, notice: 'Team invitation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def authorize_team_invitation
      authorize @team_invitation
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_team_invitation
      @team_invitation = TeamInvitation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def team_invitation_params
      params.require(:team_invitation).permit(:email, :name, :token, :team_id)
    end
end
