module Items
  class IconsController < NestedWeakResourceController
    include AccountLayout

    def self.parent_resource
      Item
    end

    def edit
      @icons = SvgIconFile.all
    end

    private
      def permitted_params
        [:icon_key]
      end

      def assign_attributes
        resource.user = current_user
        resource.account ||= parent_resource.account
        resource.parent ||= parent_resource
      end

      def find_account_by_resource
        parent_resource.account
      end
  end
end
