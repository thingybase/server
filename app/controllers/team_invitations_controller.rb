class TeamInvitationsController < ResourcesController
  def self.resource
    TeamInvitation
  end

  def permitted_params
    [:email, :name, :token, :team_id]
  end

  def resource_scope
    policy_scope.joins(:user)
  end

  def before_new
    @team_invitation.user = current_user
    @team_invitation.token ||= TeamInvitation.random_token
  end
end
