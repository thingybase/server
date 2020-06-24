module Items::Templates
  class PerishablesController < BaseController
    private
      def assign_item_attributes
        @item.container = false
      end
  end
end
