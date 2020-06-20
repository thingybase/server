module LabelsHelper
  def scan_label_url(item)
    super item.uuid
  end
end
