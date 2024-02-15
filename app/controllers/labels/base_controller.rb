module Labels
  class BaseController < Oxidizer::NestedWeakResourceController
    include AccountLayout
    include LabelsHelper
    include PreviewablePdf

    include Superview::Actions

    class Show < AccountLayout::Component
      attr_writer :label

      def title = @label.text
      def icon = @label.icon
      def subtitle
        Breadcrumb do |it|
          it.crumb { show(@account, :name) }
          @label.item.ancestors.each do |item|
            it.crumb { show(item, :name) }
          end
          it.crumb { show(@label.item, :name) }
          it.crumb { "Label" }
        end
      end

      def template
        div class: "flex flex-col gap-8" do
          Tab class: "tabs-boxed" do |it|
            it.tab(label_standard_path(@label)) { "Standard" }
            it.tab(label_jumbo_path(@label)) { "Jumbo" }
            it.tab(label_code_path(@label)) { "Handwritten" }
          end

          div(class: "bg-neutral-500 w-fit p-8 rounded w-full min-h-96") do
            img(src: url_for(format: :png), class: "mx-auto")
          end
        end
      end

      def action_template
        LinkButton(url_for(format: :pdf), :primary) { "Print" }
      end
    end

    def show
      respond_to do |format|
        format.html { render phlex, layout: false }
        format.pdf do
          send_data prawn_document.render, disposition: "inline", type: "application/pdf"
        end
        format.png do
          prawn_png do |path|
            send_file path, disposition: "inline", type: "image/png"
          end
        end
      end
    end

    def phlex
      super.tap do |view|
        view.account = @account
        view.user = current_user
      end
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
# Path: app/controllers/labels/standard_controller.rb