# TODO: This code is starting to do more than just dealing with the AccountLayout;
# for example, it's dealing with denying authorization when a user looks at an item
# on an account thats not theirs. This should probably be moved into its own class
# or rolled into an AccountResources controller.
module AccountLayout
  extend ActiveSupport::Concern

  class View < ApplicationComponent
    def initialize(key: "Items", account:, user:, notice: nil)
      @key = key
      @account = account
      @user = user
      @notice = notice
    end

    def sidebar_template
      div(class: "hidden sm:flex flex-col p-4 bg-base-200 sticky top-0 h-screen") do
        div { "SEARCH FIELD" }
        item "Dashboard", icon: "dashboard-gauge", url: account_path(@account)
        item "Items", icon: "chest", url: account_items_path(@account)
        item "People", icon: "basketball-jersey", url: account_people_path(@account)
        if list = @account.loanable_list
          item "Borrowing", icon: "heart", url: account_loanable_list_path(@account)
        end
        if move = @account.move
          item "Moving", icon: "dolly-cart", url: account_move_path(@account)
        end
        item "Profile", icon: "gears", url: user_path(@user)
      end
    end

    def template
      div(class: "flex flex-row") do
        sidebar_template
        div(class: "m-4") do
          section(class: "flex flex-col gap-4 p-4 md:gap-8 md:p-8") do
            div(class: "mb-4") { @notice } if @notice
            yield
          end
          footer class: "my-6 mx-auto sm:hidden text-center" do
            a(href: account_path(@account), class: "btn btn-ghost") { "Manage #{@account.name}" }
          end
        end
      end
    end

    def item(text, icon:, url:, active_icon: nil)
      # Active sould be bg-base-300
      a(href: account_items_path(@account), class: "p-2 rounded hover:bg-base-300") do
        render IconComponent.new(icon, class: "w-4")
        span(class: "ml-2") { text }
      end
    end
  end

  included do
    before_action :set_account_instance_variable
    layout :set_account_layout
    helper_method :navigation_key, :navigation_search_path, :navigation_search_placeholder
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
