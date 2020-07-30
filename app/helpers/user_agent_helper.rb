module UserAgentHelper
  # Figure out if we're looking at this thing via a a desktop or mobile app. These
  # will always have the user agent format of `Thingybase/1.0` in the string.
  def is_app?
    request.user_agent =~ /Thingybase/i
  end
end
