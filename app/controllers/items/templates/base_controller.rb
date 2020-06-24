module Items::Templates
  class BaseController < NestedResourcesController
    include AccountLayout

    def self.resource
      Item
    end

    def self.parent_resource
      Item
    end

    protected
      def permitted_params
        [:name, :icon_key, :shelf_life_begin, :shelf_life_end]
      end

      def assign_item_attributes
      end

      def create_redirect_url
        if @item.container?
          @item
        elsif @item.parent
          @item.parent
        else
          @item
        end
      end

    private
      def parent_resource_name
        "item_parent"
      end

      def parent_resource_id_param
        "item_id"
      end

      def assign_attributes
        self.resource.user = current_user
        self.resource.account ||= parent_resource.account
        self.resource.parent ||= parent_resource
        assign_item_attributes
      end
  end
end
