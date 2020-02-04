module AccountLayout
  extend ActiveSupport::Concern

  included do
    before_action :set_account
    layout :set_account_layout
  end

  protected
    def set_account
      @account = find_account
    end

    def find_account
      find_account_by_param || find_account_by_resource || find_account_by_resource_param
    end

  private
    def set_account_layout
      @account ? "account" : "application"
    end

    def find_account_by_param
      Account.find params[:account_id] if params.key? :account_id
    end

    def find_account_by_resource_param
      Account.find resource_params[:account_id] if params.key? resource_name
    end

    def find_account_by_resource
      resource.account if resource
    end
end