module Accounts
  class ItemsController < Oxidizer::NestedResourcesController
    include AccountLayout
    include ResourceAnalytics
    include Superview::Actions

    before_action :assign_items, only: [:new, :create]
    before_action :authorize_feature, only: [:new, :create]

    class Index < AccountLayout::Component
      attr_writer :items

      def title = @account.name
      def subtitle = "All the items you want to track"
      def icon = "chest-open"

      def action_template
        LinkButton(new_account_item_path(@account), :primary) { "+ Add items" }
        LinkButton(new_account_items_batch_path(@account)) { "Select..." }
      end

      def template
        render ListItemsComponent.new(@items.roots.container_then_item)
      end
    end

    class Form < ApplicationForm
      def template
        div(class: "join") do
          Select :container,
              [ false, "Item"],
              [ true, "Container"],
            class: "join-item input input-bordered input-primary"

          Input :name, type: :text, autofocus: true, class: "join-item input input-bordered input-primary"
          Submit(class: "join-item btn btn-primary") { "Create" }
        end
      end
    end

    class New < AccountLayout::Component
      attr_writer :item, :items

      def title = @account.name
      def subtitle = "Add an item or container"
      def icon = "chest-open"

      def template
        render Form.new(@item)

        render ListItemsComponent.new(@items.roots.container_then_item)

        a(href: templates_account_items_path(@account), class: "btn btn-outline" ){ "Create item from a template..." }
      end
    end

    def index
      render phlex, layout: false
    end

    def new
      @item = Item.new
      render phlex, layout: false
    end

    def phlex
      super.tap do |view|
        view.account = @account
        view.user = current_user
      end
    end

    def templates
      authorize @account.items.build, :new?
    end

    def authorize_feature
      current_plan.items.exceeded?
    end

    protected
      def navigation_key
        "Items"
      end

      def assign_items
        @items = resources.roots
      end

      def create_notice
        nil
      end

      def create_redirect_url
        url_for action: :new
      end

    private
      def permitted_order_params
        [:name, :created_at, :updated_at]
      end

      def permitted_params
        [:name, :account_id, :container]
      end

      def assign_attributes
        resource.user = current_user
        resource.account ||= @account
        resource.container ||= created_resource&.container
      end
  end
end
