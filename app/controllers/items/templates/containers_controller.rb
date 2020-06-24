module Items::Templates
  class ContainersController < BaseController
    private
      def assign_item_attributes
        @item.container = true
        @item.icon_key ||= "folder"
      end
  end
end
