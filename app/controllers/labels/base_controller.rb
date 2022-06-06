module Labels
  class BaseController < Resourcefully::NestedWeakResourceController
    include AccountLayout
    include LabelsHelper
    include PreviewablePdf

    def self.parent_resource
      Label
    end

    protected
      def uids
        params.fetch(:ids).split(",")
      end

      def navigation_key
        "Items"
      end
  end
end
