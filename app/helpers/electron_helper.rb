# I don't really like this approach this module takes to Electron, which is to
# sniff it out via UserAgent. Ideally we can have the Electron client app set
# a CSS mediatype or variable so we can handle this exclusively via CSS.
module ElectronHelper
  USER_AGENT = "Thingybase Desktop App".freeze
  DRAG_REGION_HEIGHT = "2rem"
  CSS_CLASS_NAME = "electron-drag-region"

  # This feels dirty. Ideally I could do this purely from CSS and control via injecting
  # a value into the CSS runtime.
  def is_electron?
    request.user_agent.include? USER_AGENT
  end

  def electron_drag_region(height: DRAG_REGION_HEIGHT, **attributes)
    return unless is_electron?
    tag.div class: CSS_CLASS_NAME, style: style(height: height, **attributes)
  end
end
