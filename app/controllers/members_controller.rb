class MembersController < ResourcesController
  before_action :set_team, only: [:new]

  def self.resource
    Member
  end

  def permitted_params
    [:user_id, :team_id]
  end

  def resource_scope
    policy_scope.joins(:user)
  end

  def before_new
    self.resource.team = @team
  end

  private
    def set_team
      @team = Team.find(params[:team_id]) if params.key? :team_id
    end
end
