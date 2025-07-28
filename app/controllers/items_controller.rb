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
      Breadcrumb do |it|
        it.crumb { show(@account, :name) }
        @item.ancestors.reverse.each do |item|
          it.crumb { show(item, :name) }
        end
        it.crumb { show(@item, :name) }
      end
    end
  end

  class Container < Show
    def view_template
      render Components::ListItemsComponent.new(@item.children.container_then_item)
    end

    def search_template
      render SearchFieldComponent.new(placeholder: "Search #{@item.name}", url: item_search_path(@item))
    end

    def action_template
      LinkButton(new_item_child_path(@item), :primary) { "+ Add items" }

      div(class: "join") do
        LinkButton(edit_item_path(@item), class: "join-item") { "Edit" }
        LinkButton(new_item_batch_path(@item), class: "join-item") { "Select" }
        LinkButton(label_path(@item.label), class: "join-item") { "Label" }
      end

      Menu title: "More..." do |it|
        it.item do
          link_to(edit_item_icon_path(@item), class: "join-item") { "Change icon" }
        end

        it.item do
          link_to(new_item_copy_path(@item)) { "Copy" }
        end

        it.item enabled: @account.loanable_list.present? do
          link_to(new_item_loanable_path(@item)) { "Loan" }
        end

        it.item enabled: @account.move.present? do
          link_to(@item.movement ? movement_path(@item.movement) : new_item_movement_path(@item)){ "Move" }
        end

        it.item do
          delete(@item, confirm: "Are you sure?") { "Delete" }
        end

        it.item do
          link_to(item_search_path(@item)) { "Search" }
        end
      end

    end
  end

  class Item < Show
    def view_template
      DataView @item do |it|
        it.field(:created_at)
        it.field(:updated_at)
        it.field(:user) { @item.user.name }
        if @item.expires_at
          it.field(:expires_at)
        end
      end
    end

    def action_template
      div(class: "join") do
        LinkButton(edit_item_path(@item), class: "join-item") { "Edit" }
        LinkButton(edit_item_icon_path(@item), class: "join-item") { "Change icon" }
        LinkButton(label_path(@item.label), class: "join-item") { "Label" }
      end

      Menu title: "More..." do |it|
        it.item do
          link_to(new_item_copy_path(@item)) { "Copy" }
        end

        it.item enabled: @account.loanable_list.present? do
          link_to(new_item_loanable_path(@item)) { "Loan" }
        end

        it.item enabled: @account.move.present? do
          link_to(@item.movement ? movement_path(@item.movement) : new_item_movement_path(@item)){ "Move" }
        end

        it.item do
          delete(@item, confirm: "Are you sure?") { "Delete" }
        end
      end
    end
  end

  def show
    view_class = @item.container? ? Container : Item
    view = assign_component_accessors(view_class.new)
    view.user = current_user

    render assign_component_accessors(view), layout: false
  end

  class Form < DataForm
    def view_template
      TextField :name

      SelectField :parent, [nil, items.select(:id, :name)],
        label: "Contained In"

      TextField :expires_at,
        hint: 'Dates like "6 months from now", "next week", "Feb 2021" all work'

      CheckboxField :container do |it|
        it.label
        it.field do |it|
          it.checkbox
          it.label { "Allow items to be contained within this item. For boxes, shelfs and other containers." }
        end
      end

      Submit { "Save" }
    end

    def items
      helpers.account_policy_scope(::Item.container)
    end
  end

  class Edit < Show
    def view_template
      render Form.new(@item)
    end

    def subtitle
      Breadcrumb do |it|
        it.crumb { show(@account, :name) }
        @item.ancestors.each do |item|
          it.crumb { show(item, :name) }
        end
        it.crumb { show(@item, :name) }
        it.crumb { "Edit" }
      end
    end
  end

  def edit
    render phlex, layout: false
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
