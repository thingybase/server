module Labels
  class BatchesController < ApplicationController
    include LabelsHelper

    skip_after_action :verify_authorized
    after_action :verify_policy_scoped

    def show
      @labels = policy_scope Label.where(id: ids)

      respond_to do |format|
        format.html
        format.pdf do
          send_data label_generator(@labels).render_pdf,
            disposition: "inline",
            type: "application/pdf",
            filename: "labels.pdf"
        end
      end
    end

    protected
      def ids
        params.fetch(:ids).split(",").map{ |id| Integer(id) }
      end

      def label_generator(resources)
        label_layout = case params[:size]
        when "large"
          LabelGenerator::LARGE_LAYOUT
        else
          LabelGenerator::SMALL_LAYOUT
        end

        LabelGenerator.new(layout: label_layout).tap do |generator|
          Array(resources).each do |r|
            generator.add_label text: r.text, url: scan_label_url(r) do |label|
              label.lines << "Created #{r.item.created_at.to_date.to_s(:long)}" if r.item
              label.lines << r.uuid
            end
          end
        end
      end
  end
end
