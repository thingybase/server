class AccountsController < ResourcesController
  layout "account", except: %i[index new]
  after_action :add_current_user_to_members, only: :create

  def self.resource
    Account
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

  def show
    respond_to do |format|
      format.html { redirect_to account_labels_url(@account) }
      format.json
    end
  end
end
