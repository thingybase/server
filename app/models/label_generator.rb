require 'prawn/qrcode'

include Prawn::Measurements

class LabelGenerator
  attr_accessor :labels, :margin

  # Basic data structure for creating labels, used internally by LabelGenerator.
  # This should stay agnostic to ActiveRecord implementation of Label model so that
  # its more portablw.
  Label = Struct.new(:text, :url, :lines)

  # Used to validate and normialize HTTP urls.
  DEFAULT_URL_SCHEME = 'http:////'.freeze

  # Dimensions of Dymo address labels
  DEFAULT_HEIGHT = mm2pt(22)
  DEFAULT_WIDTH = mm2pt(62)
  DEFAULT_QR_CODE_SIZE = mm2pt(22)
  # Font sizes
  TITLE_FONT_SIZE = 24
  DETAIL_FONT_SIZE = 8
  DEFAULT_MARGIN = 6
  DEFAULT_GUTTER_SIZE = 5

  def initialize(labels: [], margin: DEFAULT_MARGIN)
    self.labels = labels
    self.margin = margin
  end

  def add_label(text:, url:, lines: nil)
    labels.append Label.new(text, url, lines)
  end

  def render_pdf
    pdf.render.to_s
  end

  private
    def pdf
      sheets do |pdf, label|
        # Title text
        if label.lines&.any?
          pdf.grid([0,0], [3,3]).bounding_box do
              # pdf.stroke_bounds
              pdf.text_box label.text,
                size: TITLE_FONT_SIZE,
                align: :left,
                overflow: :shrink_to_fit,
                style: :bold,
                valign: :top
          end

          # Details
          pdf.grid([4,0], [5,3]).bounding_box do
            # pdf.stroke_bounds
            pdf.text_box label.lines.join("\n"),
              size: DETAIL_FONT_SIZE,
              align: :left,
              overflow: :shrink_to_fit,
              valign: :bottom
          end
        else
          pdf.grid([0,0], [5,3]).bounding_box do
              # pdf.stroke_bounds
              pdf.text_box label.text,
                size: TITLE_FONT_SIZE,
                align: :left,
                overflow: :shrink_to_fit,
                style: :bold,
                valign: :center
          end
        end

        # QR Code
        pdf.grid([0,4], [5,5]).bounding_box do
            # pdf.stroke_bounds
            pdf.print_qr_code well_formed_url(label.url),
              extent: pdf.bounds.width,
              margin: 0,
              stroke: true
        end
      end
    end

    def well_formed_url(url)
      URI(DEFAULT_URL_SCHEME).merge(url).to_s
    end

    # We dynamically change the height of a sheet dependong on how much content is on it because
    # we're printing from a roll of tape.
    def sheets(&block)
      pdf = Prawn::Document::new skip_page_creation: true
      pdf.define_grid(columns: 6, rows: 6, gutter: DEFAULT_MARGIN)
      labels.each do |label|
        pdf.start_new_page size: [DEFAULT_WIDTH, DEFAULT_HEIGHT], margin: DEFAULT_MARGIN
        block.call pdf, label
      end
      pdf
    end
end
