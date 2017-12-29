module Teams
  class MembersController < ResourcesController
    include TeamLayout

    def self.resource
      Member
    end

    def self.parent_resource
      Team
    end

    def resource_scope
      policy_scope.joins(:user)
    end

    def permitted_params
      [:user_id, :team_id]
    end

    def assign_attributes
      self.resource.team = @team
    end

    def destroy_redirect_url
      team_members_url @team
    end
  end
end
