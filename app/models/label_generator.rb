require 'prawn/qrcode'

include Prawn::Measurements

class LabelGenerator
  attr_accessor :labels, :layout

  # Basic data structure for creating labels, used internally by LabelGenerator.
  # This should stay agnostic to ActiveRecord implementation of Label model so that
  # its more portablw.
  Label = Struct.new(:text, :url, :lines,
    keyword_init: true)

  # Used to validate and normialize HTTP urls.
  DEFAULT_URL_SCHEME = 'http:////'.freeze

  # Controls spacing, margins, and page dimensions of label.
  Layout = Struct.new(:height, :width, :title_font_size, :detail_font_size, :margin,
    keyword_init: true)

  # Dimensions of Dymo address labels on a roll
  LARGE_LAYOUT = Layout.new(
    height: mm2pt(62),
    width: mm2pt(175),
    title_font_size: 68,
    detail_font_size: 22,
    margin: 16)

  # Dimensions of Dymo address labels on a roll
  SMALL_LAYOUT = Layout.new(
    height: mm2pt(22),
    width: mm2pt(62),
    title_font_size: 24,
    detail_font_size: 8,
    margin: 5)

  def initialize(labels: [], layout: LARGE_LAYOUT)
    self.labels = labels
    self.layout = layout
  end

  def add_label(text:, url:, lines: [])
    label = Label.new(text: text, url: url, lines: lines)
    yield label if block_given?
    labels.append label
  end

  def prawn_document
    pdf
  end

  def render_pdf
    pdf.render.to_s
  end

  def render_pdf_file(path)
    pdf.render_file path
  end

  # TODO: This has hit peak complexity. If anything is added to it, it should be refactored
  # into its own class. This method is doing too much, and its doing stuff that the Label
  # class is already doing. What should probably be done is delegate some of the Label class
  # to an associated item, if its present; and handle the logic of what text gets displayed.
  def self.batch(resources, size:)
    label_layout = case size
    when "large"
      LabelGenerator::LARGE_LAYOUT
    else
      LabelGenerator::SMALL_LAYOUT
    end

    LabelGenerator.new(layout: label_layout).tap do |generator|
      Array(resources).each do |r|
        generator.add_label text: r.text, url: Rails.application.routes.url_helpers.scan_label_url(r) do |label|
          date = if r.item&.expires_at
            "Expires #{r.item.expires_at.to_date}"
          elsif r.item
            "Created #{r.item.created_at.to_date}"
          end
          label.lines << [date, r.code].join(" · ")
        end
      end
    end
  end

  private
    def pdf
      sheets do |pdf, label|
        # Title text
        if label.lines&.any?
          pdf.grid([0,0], [3,3]).bounding_box do
              # pdf.stroke_bounds
              pdf.text_box label.text,
                size: layout.title_font_size,
                align: :left,
                overflow: :shrink_to_fit,
                style: :bold,
                valign: :top
          end

          # Details
          pdf.grid([4,0], [5,3]).bounding_box do
            # pdf.stroke_bounds
            pdf.text_box label.lines.join("\n"),
              size: layout.detail_font_size,
              align: :left,
              overflow: :shrink_to_fit,
              valign: :bottom
          end
        else
          pdf.grid([0,0], [5,3]).bounding_box do
              # pdf.stroke_bounds
              pdf.text_box label.text,
                size: layout.title_font_size,
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
      pdf.font_families.update(
        "Inter" => {
          :bold        => Rails.root.join("app/assets/fonts/inter/ttf/Inter-Bold.ttf"),
          :italic      => Rails.root.join("app/assets/fonts/inter/ttf/Inter-Italic.ttf"),
          :bold_italic => Rails.root.join("app/assets/fonts/inter/ttf/Inter-BoldItalic.ttf"),
          :normal      => Rails.root.join("app/assets/fonts/inter/ttf/Inter-Regular.ttf")
        }
      )
      pdf.define_grid(columns: 6, rows: 6, gutter: layout.margin)
      labels.each do |label|
        pdf.start_new_page size: [layout.width, layout.height], margin: layout.margin
        pdf.font "Inter" do
          block.call pdf, label
        end
      end
      pdf
    end
end
