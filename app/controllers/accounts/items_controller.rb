module Accounts
  class ItemsController < Oxidizer::NestedResourcesController
    include AccountLayout
    include ResourceAnalytics
    include Superview::Actions

    before_action :assign_items, only: [:new, :create]
    before_action :authorize_feature, only: [:new, :create]

    class View < AccountLayout::View
      def action_template
      end

      def title_template
        render PageTitleComponent.new(title: title, subtitle: subtitle, icon: icon) if title
      end

      def around_template
        super do
          title_template

          div(class: "flex flex-row gap-2") do
            action_template
          end

          div do
            yield
          end
        end
      end
    end

    class Index < View
      attr_writer :items, :account

      def title = @account.name
      def subtitle = "All the items you want to track"
      def icon = "chest-open"

      def action_template
        a(href: new_account_item_path(@account), class: "btn btn-primary" ){ "+ Add items" }
        a(href: new_account_items_batch_path(@account), class: "btn"){ "Select..." }
      end

      def template
        section do
          @items.roots.container_then_item.each do |it|
            render ItemListCardComponent.new(item: it)
          end
        end
      end
    end

    def index
      render(Index.new(user: current_user, account: @account).tap do |c|
        c.items = resources
      end, layout: false)
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
