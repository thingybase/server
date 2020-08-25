# TODO: This code is starting to do more than just dealing with the AccountLayout;
# for example, it's dealing with denying authorization when a user looks at an item
# on an account thats not theirs. This should probably be moved into its own class
# or rolled into an AccountResources controller.
module AccountLayout
  extend ActiveSupport::Concern

  included do
    before_action :set_account_instance_variable
    layout :set_account_layout
    helper_method :navigation_section
  end

  protected
    def navigation_section
    end

    def request_forbidden(exception)
      @member_request = MemberRequest.new(account: find_account, user: current_user)
      super(exception)
    end

  private
    def set_account_instance_variable
      @account = find_account
    end

    def set_account_layout
      @account ? "account" : "application"
    end
end
