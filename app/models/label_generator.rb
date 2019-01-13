require 'prawn/qrcode'

include Prawn::Measurements

class LabelGenerator
  attr_accessor :url, :text, :margin, :height, :width

  DEFAULT_URL_SCHEME = 'http:////'.freeze

  # Dimensions of Dymo address labels
  DEFAULT_HEIGHT = mm2pt(22)
  DEFAULT_WIDTH = mm2pt(62)

  def initialize(text:, url: nil, width: DEFAULT_WIDTH, height: DEFAULT_HEIGHT)
    self.url = url
    self.text = text
    self.width = width
    self.height = height
    self.margin = 0
  end

  def pdf
    url ? url_label : basic_label
  end

  def render_pdf
    pdf.render.to_s
  end

  def url
    URI(DEFAULT_URL_SCHEME).merge(@url) if @url
  end

  private
    def basic_label
      label do |pdf|
        pdf.text text, align: :center, valign: :center, size: 24, style: :bold
      end
    end

    def url_label
      qrcode_size = height
      qrcode_offset = width - qrcode_size
      margin = 5

      label do |pdf|
        pdf.bounding_box [margin, height - margin], width: qrcode_offset - margin, height: height - (margin * 2) do
          # pdf.stroke_bounds
          pdf.text_box text, align: :left, valign: :center, overflow: :shrink_to_fit,
            size: 24, style: :bold
        end
        pdf.bounding_box [qrcode_offset, qrcode_size], width: qrcode_size, height: qrcode_size do
          # pdf.stroke_bounds
          # TODO: Fix bug here; `margin: 0` didn't work, so I hacked everything else up.
          pdf.print_qr_code url.to_s, extent: qrcode_size, stroke: false
        end
      end
    end

    def label(&block)
      Prawn::Document::new page_size: [width, height], margin: 0, &block
    end
end
