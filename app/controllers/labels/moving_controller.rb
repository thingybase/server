module Labels
  class MovingController < BaseController
    private
      def destination_name
        @label&.item&.parent&.name || @account.name
      end

      def prawn_document
        sheets = PdfSheets.new(columns: 12, rows: 12, height: mm2pt(62), width: mm2pt(100))
        pdf = sheets.pdf

        sheets.add do
          # Destination of the item.
          sheets.grid_box(top: 0, left: 0, height: 6, width: 12) do
            sheets.add_large_text destination_name, size: 100, valign: :center, align: :center
          end

          # Spacer and line to seperate title up top from everything else.
          sheets.grid_box(top: 6, left: 0, height: 1, width: 12) do
            pdf.line_width 0.5
            pdf.pad 5 do
              pdf.stroke_horizontal_rule
            end
          end

          # QR code so people can scan the item.
          sheets.grid_box(top: 7, left: 9, height: 5, width: 3) do
            sheets.qr_code scan_label_url(@label)
          end

          # Name of the item, which describes the contents.
          sheets.grid_box(top: 7, left: 0, height: 4, width: 9) do
            sheets.add_text @label.text, valign: :top, size: 16
          end

          # Meta data in case the QR code gets damanged.
          sheets.grid_box(top: 11, left: 0, height: 1, width: 9) do
            sheets.add_text "Label #{@label.uuid} created #{@label.created_at.to_date}"
          end
        end

        pdf
      end
  end
end
