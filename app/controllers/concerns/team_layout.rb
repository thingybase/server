module TeamLayout
  extend ActiveSupport::Concern

  included do
    before_action :set_team
    layout :set_team_layout
  end

  protected
    def set_team
      @team = if params.key? :team_id
        Team.find params[:team_id]
      elsif resource
        resource.team
      end
    end

  private
    def set_team_layout
      @team ? "team" : "application"
    end
end