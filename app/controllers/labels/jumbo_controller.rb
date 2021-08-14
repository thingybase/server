module Labels
  class JumboController < BaseController
    private
      def prawn_document
        LabelGenerator.batch(resource, size: "large").prawn_document
      end
  end
end
