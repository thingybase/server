class AccountsController < Oxidizer::ResourcesController
  include AccountLayout
  after_action :add_current_user_to_members, only: :create

  layout -> {
    case action_name
    when "new"
      "focused"
    when "show", "edit"
      account_layout
    else
      "application"
    end
  }

  before_action { @stats = Components::Account::Stats.new(@account) }

  def show
    respond_to do |format|
      format.html
      format.turbo_stream { replace(@stats) }
    end
  end

  protected def replace(component)
    render turbo_stream: turbo_stream.replace(component.dom_id, component)
  end

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
