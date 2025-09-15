class Components::AccountComponent < Components::Base
  attr_writer :user, :account

  include Phlex::Rails::Layout

  module Aliases
    def Form(...)
      render Form.new(...)
    end

    def LinkButton(url, *modifiers, **attributes, &)
      a(href: url, class: ["btn", modifiers.map{ "btn-#{_1}" }, attributes[:class]], &)
    end

    def Menu(...)
      render Components::MenuComponent.new(...)
    end

    def DataView(...)
      render Components::DataViewComponent.new(...)
    end

    def Breadcrumb(...)
      render Components::BreadcrumbComponent.new(...)
    end

    def Tab(...)
      render Components::TabComponent.new(...)
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
    render Views::Layouts::Base.new(title: method(:title)) do
      div(class: "flex flex-row") do
        sidebar_template
        yield
      end
    end
  end

  def view_template
    div(class: "m-4 flex flex-col w-full") do
      section(class: "flex flex-col gap-4 p-4 md:gap-8 md:p-8") do
        div(class: "mb-4") { @notice } if @notice
        yield
      end

      footer class: "my-6 mx-auto sm:hidden text-center" do
        a(href: account_path(@account), class: "btn btn-ghost") { "Manage #{@account.name}" }
      end
    end
  end

  def sidebar_template
    div(class: "hidden md:flex flex-col p-4 bg-base-200 sticky top-0 h-screen") do
      div class: "mb-2" do
        search_template
      end

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
    render SearchFieldComponent.new(placeholder: "Search #{@account.name}", url: account_search_path(@account))
  end

  def item(text, icon:, url:, active_icon: icon)
    if active = text == @key
      icon = active_icon
      active_css = nil
    end

    a(href: url, class: [active_css, "p-2 flex flex-row items-center gap-2 rounded hover:bg-base-300 whitespace-nowrap"]) do
      render IconComponent.new(icon)
      span { text }
    end
  end
end
