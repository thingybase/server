module AccountLayout
  extend ActiveSupport::Concern

  included do
    before_action :set_account_instance_variable
    layout :set_account_layout
  end

  private
    def set_account_instance_variable
      @account = find_account
    end

    def set_account_layout
      @account ? "account" : "application"
    end
end