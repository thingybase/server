class AccountsController < Oxidizer::ResourcesController
  include AccountLayout
  after_action :add_current_user_to_members, only: :create

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

    def set_account_layout
      case action_name
      when "new", "index"
        "focused"
      when "show", "edit"
        "account"
      else
        "application"
      end
    end
end
