class MovementsController < Oxidizer::ResourcesController
  include AccountLayout
  include PreviewablePdf

  def self.resource
    Movement
  end

  def index
    redirect_to @move
  end

  protected
    def navigation_key
      "Moving"
    end

    def destroy_redirect_url
      [@movement.move, :movements]
    end

    def permitted_params
      [:origin_id, :destination_id]
    end

  private
    def prawn_document
      sheets = PdfSheets.new(columns: 12, rows: 12, height: mm2pt(62), width: mm2pt(100))
      pdf = sheets.pdf

      sheets.add do
        # Destination of the item.
        sheets.grid_box(top: 0, left: 0, height: 6, width: 12) do
          sheets.add_large_text @movement.destination.name, size: 100, valign: :center, align: :center
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
          sheets.qr_code movement_scan_url(@movement)
        end

        # Name of the item, which describes the contents.
        sheets.grid_box(top: 7, left: 0, height: 4, width: 9) do
          sheets.add_text @movement.origin.name, valign: :top, size: 16
        end

        # Meta data in case the QR code gets damanged.
        sheets.grid_box(top: 11, left: 0, height: 1, width: 9) do
          sheets.add_text "Movement #{@movement.uuid} created #{@movement.created_at.to_date}"
        end
      end

      pdf
    end
end
