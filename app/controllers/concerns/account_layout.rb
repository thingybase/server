module AccountLayout
  extend ActiveSupport::Concern

  included do
    before_action :set_account
    layout :set_account_layout
  end

  protected
    def set_account
      @account = if params.key? :account_id
        Account.find params[:account_id]
      elsif resource
        resource.account
      end
    end

  private
    def set_account_layout
      @account ? "account" : "application"
    end
end