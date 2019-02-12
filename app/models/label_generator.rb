require 'prawn/qrcode'

include Prawn::Measurements

class LabelGenerator
  attr_accessor :labels, :margin, :height, :width

  # Basic data structure for creating labels, used internally by LabelGenerator.
  # This should stay agnostic to ActiveRecord implementation of Label model so that
  # its more portablw.
  Label = Struct.new(:text, :url)

  # Used to validate and normialize HTTP urls.
  DEFAULT_URL_SCHEME = 'http:////'.freeze

  # Dimensions of Dymo address labels
  DEFAULT_HEIGHT = mm2pt(22)
  DEFAULT_WIDTH = mm2pt(62)

  def initialize(labels: [], width: DEFAULT_WIDTH, height: DEFAULT_HEIGHT)
    self.labels = labels
    self.width = width
    self.height = height
    self.margin = 0
  end

  def add_label(text:, url:)
    labels.append Label.new(text, url)
  end

  def render_pdf
    pdf.render.to_s
  end

  private
    def pdf
      qrcode_size = height
      qrcode_offset = width - qrcode_size
      margin = 5

      document do |pdf|
        labels.each.with_index(1) do |label, page_count|
          pdf.bounding_box [margin, height - margin], width: qrcode_offset - margin, height: height - (margin * 2) do
            # pdf.stroke_bounds
            pdf.text_box label.text, align: :left, valign: :center, overflow: :shrink_to_fit,
              size: 24, style: :bold
          end
          pdf.bounding_box [qrcode_offset, qrcode_size], width: qrcode_size, height: qrcode_size do
            # pdf.stroke_bounds
            # TODO: Fix bug here; `margin: 0` didn't work, so I hacked everything else up.
            pdf.print_qr_code well_formed_url(label.url), extent: qrcode_size, stroke: false
          end
          pdf.start_new_page if page_count < labels.count
        end
      end
    end

    def well_formed_url(url)
      URI(DEFAULT_URL_SCHEME).merge(url).to_s
    end

    def document(&block)
      Prawn::Document::new page_size: [width, height], margin: 0, &block
    end
end
