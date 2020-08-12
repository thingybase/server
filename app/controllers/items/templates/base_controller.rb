module Items::Templates
  class BaseController < ResourcesController
    include AccountLayout

    helper_method :icons

    protected
      def self.resource
        Item
      end

      def permitted_params
        [:name, :icon_key, :shelved_at, :expires_at]
      end

      def icons
        SvgIconFile.all
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
      def find_account
        if params.key? :account_id
          Account.find_resource params.fetch(:account_id)
        elsif parent_item
          parent_item.account
        end
      end

      def find_parent_item
        Item.find_resource params.fetch(:item_id) if params.key? :item_id
      end

      def account
        @_account ||= find_account
      end

      def parent_item
        @_parent_item ||= find_parent_item
      end

      def assign_attributes
        @item.user = current_user
        @item.account ||= parent_item&.account || find_account
        @item.parent ||= parent_item
        assign_item_attributes
      end
  end
end
