class ItemsController < Oxidizer::ResourcesController
  include AccountLayout
  include ResourceAnalytics
  include Superview::Actions

  before_action :assign_opengraph_attributes, only: :show

  def phlex
    super.tap do |view|
      view.account = @account
      view.user = current_user
    end
  end

  class Show < AccountLayout::Component
    attr_writer :item

    def title = @item.name
    def icon = @item.icon
    def subtitle
      div(class: "breadcrumbs m-0 p-0") do
        ul do
          li { show(@account, :name) }
          @item.ancestors.each do |item|
            li { show(item, :name) }
          end
          li { show(@item, :name) }
        end
      end
    end
  end

  class Container < Show
    def template
      render ListItemsComponent.new(@item.children.container_then_item)
    end

    def action_template
      LinkButton(new_item_child_path(@item), :primary) { "+ Add items" }

      div(class: "join") do
        LinkButton(edit_item_path(@item), class: "join-item") { "Edit" }
        LinkButton(new_item_batch_path(@item), class: "join-item") { "Select" }
        LinkButton(label_path(@item.label), class: "join-item") { "Label" }
        LinkButton(edit_item_icon_path(@item), class: "join-item") { "Change icon" }
      end
    end
  end

  class Item < Show
    def template
      render DataViewComponent.new(@item) do |it|
        it.field(:created_at)
        it.field(:updated_at)
        it.field(:user) { @item.user.name }
      end
    end

    def action_template
      div(class: "join") do
        LinkButton(edit_item_path(@item), class: "join-item") { "Edit" }
        LinkButton(edit_item_icon_path(@item), class: "join-item") { "Change icon" }
        LinkButton(label_path(@item.label), class: "join-item") { "Label" }
      end

      LinkButton(new_item_copy_path(@item)) { "Copy" }

      if @account.move
        link_to(@item.movement ? movement_path(@item.movement) : new_item_movement_path(@item)){ "Move" }
      end

      delete(@item, confirm: "Are you sure?", class: "btn") { "Delete" }
    end
  end

  def show
    view_class = @item.container? ? Container : Item
    view = assign_phlex_accessors(view_class.new)
    view.user = current_user

    render assign_phlex_accessors(view), layout: false
  end

  protected
    def navigation_key
      "Items"
    end

  private
    # We want to show these when access is denied for people who are not logged in.
    def deny_opengraph_format
      assign_resource_instance_variable if member_request?
      render layout: "application"
    end

    def destroy_redirect_url
      @item.parent || account_items_url(@item.account)
    end

    def permitted_order_params
      [:name, :created_at, :updated_at]
    end

    def permitted_params
      [:name, :account_id, :parent_id, :expires_at, :container, :icon_key]
    end

    def assign_opengraph_attributes
      opengraph.title = resource.name
    end
end
