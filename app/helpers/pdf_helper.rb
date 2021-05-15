require 'prawn/qrcode'

module PdfHelper
  include Prawn::Measurements

  def pdf_sheets(**kwargs, &block)
    sheets = PdfSheets.new(**kwargs)
    block.call sheets, sheets.pdf
    sheets.render
  end
end
