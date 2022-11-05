module Labels
  class BaseController < Oxidizer::NestedWeakResourceController
    include AccountLayout
    include LabelsHelper
    include PreviewablePdf

    protected
      def uids
        params.fetch(:ids).split(",")
      end

      def navigation_key
        "Items"
      end
  end
end
