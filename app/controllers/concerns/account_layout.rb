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

  class Component < AccountComponent
    attr_reader :title, :subtitle, :icon

    def title_template
      render PageTitleComponent.new(title: title, subtitle: -> { subtitle }, icon: icon) if title
    end

    def around_template
      super do
        div(class: "m-4 flex flex-col") do
          section(class: "flex flex-col gap-4 p-4 md:gap-8 md:p-8") do
            title_template

            if respond_to? :action_template
              div(class: "flex flex-row gap-2") do
                action_template
              end
            end

            div(class: "mb-4") { @notice } if @notice

            yield
          end

          footer class: "my-6 mx-auto sm:hidden text-center" do
            a(href: account_path(@account), class: "btn btn-ghost") { "Manage #{@account.name}" }
          end
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
