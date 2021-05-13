pdf_sheets columns: 12, rows: 12, height: mm2pt(62), width: mm2pt(100) do |sheets, pdf|
  sheets.add do
    sheets.grid_box(top: 0, left: 0, height: 6, width: 12) do
      # pdf.text_box "Please move me to the:", size: 9
      sheets.add_large_text @label.item.parent.name, size: 100, valign: :center, align: :center
    end

    sheets.grid_box(top: 7, left: 9, height: 5, width: 3) do
      sheets.qr_code scan_label_url(@label)
    end

    sheets.grid_box(top: 6, left: 0, height: 1, width: 12) do
      pdf.line_width 0.5
      pdf.pad 5 do
        pdf.stroke_horizontal_rule
      end
    end

    sheets.grid_box(top: 7, left: 0, height: 4, width: 9) do
      sheets.add_text @label.item.name, valign: :top
    end

    sheets.grid_box(top: 11, left: 0, height: 1, width: 9) do
      sheets.add_text "Label #{@label.uuid} created #{@label.item.created_at.to_date}"
    end
  end
end
