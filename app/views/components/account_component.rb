class AccountComponent < ApplicationComponent
  attr_writer :user, :account

  module Aliases
    def Form(...)
      render Form.new(...)
    end

    def LinkButton(url, *modifiers, **attributes, &)
      a(href: url, class: tokens("btn", modifiers.map{ "btn-#{_1}" }, attributes[:class]), &)
    end

    def Menu(...)
      render MenuComponent.new(...)
    end

    def DataView(...)
      render DataViewComponent.new(...)
    end

    def Breadcrumb(...)
      render BreadcrumbComponent.new(...)
    end
  end

  include Aliases

  def initialize(key: "Items", account: nil, user: nil, notice: nil)
    @account = account
    @user = user
    @key = key
    @notice = notice
  end

  def around_template(&)
    render ApplicationLayout.new(title: title) do
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
  end

  def sidebar_template
    div(class: "hidden md:flex flex-col p-4 bg-base-200 sticky top-0 h-screen") do
      render SearchFieldComponent.new

      item "Dashboard", icon: "dashboard-gauge", url: account_path(@account)
      item "Items", icon: "chest", active_icon: "chest-open", url: account_items_path(@account)
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

  def search_template
    render SearchFieldComponent.new
  end

  def item(text, icon:, url:, active_icon: nil)
    # Active sould be bg-base-300
    active_icon ||= icon

    if active = text == @key
      icon = active_icon
      active_css = "bg-base-300"
    end

    a(href: url, class: tokens(active_css, "p-2 rounded hover:bg-base-300")) do
      render IconComponent.new(icon, class: "w-4")
      span(class: "ml-2") { text }
    end
  end
end
