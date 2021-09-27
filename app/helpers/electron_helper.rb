# I don't really like this approach this module takes to Electron, which is to
# sniff it out via UserAgent. Ideally we can have the Electron client app set
# a CSS mediatype or variable so we can handle this exclusively via CSS.
module ElectronHelper
  USER_AGENT = "Thingybase Desktop App".freeze

  # This feels dirty. Ideally I could do this purely from CSS and control via injecting
  # a value into the CSS runtime.
  def is_electron?
    request.user_agent.include? USER_AGENT
  end
end
