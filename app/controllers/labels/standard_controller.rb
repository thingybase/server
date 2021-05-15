module Labels
  class StandardController < BaseController
    private
      def prawn_document
        LabelGenerator.batch(resource, size: params[:size]).prawn_document
      end
  end
end
