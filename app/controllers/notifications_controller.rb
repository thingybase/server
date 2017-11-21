class NotificationsController < ResourcesController
  before_action :set_team

  def self.resource
    Notification
  end

  def permitted_params
    [:subject, :message, :team_id]
  end

  def resource_scope
    policy_scope.includes(:team)
  end

  def before_new
    self.resource.user = current_user
    self.resource.team ||= @team
  end

  private
    def set_team
      @team = Team.find(params[:team_id]) if params.key? :team_id
    end
end
