module Items::Templates
  class ItemsController < BaseController
    private
      def assign_item_attributes
        @item.icon_key ||= "object"
      end
  end
end
