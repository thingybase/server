# TODO: This code is starting to do more than just dealing with the AccountLayout;
# for example, it's dealing with denying authorization when a user looks at an item
# on an account thats not theirs. This should probably be moved into its own class
# or rolled into an AccountResources controller.
module AccountLayout
  extend ActiveSupport::Concern

  included do
    before_action :set_account_instance_variable
    layout :set_account_layout
    helper_method :navigation_key, :navigation_search_path, :navigation_search_placeholder
  end

  class View < ApplicationComponent
    def initialize(account:, user:)
      @account = account
      @user = user
    end

    def around_template
      render ApplicationLayout.new(title: title) do
        render AccountComponent.new(account: @account, user: @user, notice: @notice) do
          yield
        end
      end
    end
  end

  protected
    def navigation_key
    end

    def navigation_search_path
      if navigation_search_item
        item_search_path(navigation_search_item)
      else
        account_search_path(@account)
      end
    end

    def navigation_search_placeholder
      if navigation_search_item
        "Search #{navigation_search_item.name}"
      else
        "Search items"
      end
    end

    def navigation_search_item
      return unless @item

      if @item.container? && @item.persisted?
        @item
      elsif @item.parent
        @item.parent
      end
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
      @account&.persisted? ? "account" : "application"
    end
end
