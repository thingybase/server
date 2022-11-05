module Items
  class AncestorsController < Oxidizer::NestedWeakResourceController
    include AccountLayout

    private
      def navigation_key
        "Items"
      end
  end
end
