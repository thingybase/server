module Items
  class IconsController < Resourcefully::NestedWeakResourceController
    include AccountLayout

    def self.parent_resource
      Item
    end

    def edit
      @icons = Icon.all
    end

    private
      def navigation_key
        "Items"
      end

      def permitted_params
        [:icon_key]
      end

      def assign_attributes
        resource.user = current_user
        resource.account ||= parent_resource.account
        resource.parent ||= parent_resource
      end
  end
end
