module Items
  class AncestorsController < Resourcefully::NestedWeakResourceController
    include AccountLayout

    def self.parent_resource
      Item
    end

    private
      def navigation_key
        "Items"
      end
  end
end
