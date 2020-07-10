module Items::Templates
  class BaseController < ResourcesController
    include AccountLayout

    def self.resource
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
      def find_account
        Account.find_resource params.fetch(:account_id) if params.key? :account_id
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
