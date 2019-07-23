class AccountsController < ResourcesController
  layout "account", except: %i[index new]
  after_action :add_current_user_to_members, only: :create

  def self.resource
    Account
  end

  def show
    render layout: "application"
  end

  def launch
    authorize Account, :index?

    redirect_url = case policy_scope.count
      when 0
        new_account_url
      when 1
        account_containers_url policy_scope.first
      else
        accounts_url
      end

    redirect_to redirect_url
  end

  def add_current_user_to_members
    @account.members.create!(user: current_user) if @account.valid?
  end

  def permitted_params
    [:name]
  end

  def resource_scope
    policy_scope.joins(:user)
  end
end
