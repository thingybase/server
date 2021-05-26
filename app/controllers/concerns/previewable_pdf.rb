# Deals with rendering a PDF for the #show action, and a .png that can be used
# to preview the PDF without having all sorts of weird PDF viewer artifacts.
module PreviewablePdf
  extend ActiveSupport::Concern

  included do
    include Prawn::Measurements
  end

  def show
    respond_to do |format|
      format.html
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

  private
    def prawn_png(&block)
      Dir.mktmpdir do |dir|
        dir = Pathname.new Dir.mktmpdir
        pdf_path = dir.join("file.pdf")
        png_path = dir.join("file.png")

        prawn_document.render_file pdf_path

        pdf_image = MiniMagick::Image.open pdf_path

        MiniMagick::Tool::Convert.new do |convert|
          convert.flatten
          convert.density 300
          convert.quality 100
          convert << pdf_image.pages.first.path
          convert << "png8:#{png_path}"
        end

        block.call png_path
      end
    end

    def prawn_document
      Prawn::Document::new
    end
end