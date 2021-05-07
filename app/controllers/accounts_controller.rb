class AccountsController < ResourcesController
  include AccountLayout
  after_action :add_current_user_to_members, only: :create
  layout "focused", only: %w[new index]

  def self.resource
    Account
  end

  private
    def navigation_key
      "Dashboard"
    end

    # After we create an account, add the current user that just created the account as the owner.
    def add_current_user_to_members
      @account.members.create!(user: current_user) if @account.valid?
    end

    def permitted_params
      [:name]
    end

    def resource_scope
      policy_scope.joins(:user)
    end

    def find_account
      @account
    end
end
