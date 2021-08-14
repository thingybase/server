module Labels
  class StandardController < BaseController
    private
      def prawn_document
        LabelGenerator.batch(resource, size: "standard").prawn_document
      end
  end
end
