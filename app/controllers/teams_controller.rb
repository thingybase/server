class TeamsController < ResourcesController
  layout "team", except: %i[index new]
  after_action :add_current_user_to_members, only: :create

  def self.resource
    Team
  end

  def add_current_user_to_members
    @team.members.create!(user: current_user) if @team.valid?
  end

  def permitted_params
    [:name]
  end

  def resource_scope
    policy_scope.joins(:user)
  end
end
