module Labels
  class CodeController < BaseController
    private
      def prawn_document
        layout = LabelGenerator::SMALL_LAYOUT

        pdf = Prawn::Document::new skip_page_creation: true
        pdf.font_families.update(
          "Inter" => {
            :bold        => Rails.root.join("app/assets/fonts/inter/ttf/Inter-Bold.ttf"),
            :italic      => Rails.root.join("app/assets/fonts/inter/ttf/Inter-Italic.ttf"),
            :bold_italic => Rails.root.join("app/assets/fonts/inter/ttf/Inter-BoldItalic.ttf"),
            :normal      => Rails.root.join("app/assets/fonts/inter/ttf/Inter-Regular.ttf")
          }
        )
        pdf.define_grid(columns: 6, rows: 6, gutter: layout.margin)
        pdf.start_new_page size: [layout.width, layout.height], margin: layout.margin
        pdf.font "Inter" do
          pdf.grid([0,0], [4,5]).bounding_box do
            # pdf.stroke_bounds
            pdf.text_box @label.code,
              size: 100,
              align: :center,
              overflow: :shrink_to_fit,
              style: :bold,
              valign: :center
          end

          pdf.grid([4,0], [5,5]).bounding_box do
            # pdf.stroke_bounds
            pdf.text_box "Login to www.thingybase.com and search for this code",
              size: layout.detail_font_size,
              align: :center,
              overflow: :shrink_to_fit,
              valign: :center
          end
        end
        pdf
      end
  end
end
