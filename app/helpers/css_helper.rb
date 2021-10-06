module CssHelper
  # Useful for injecting inline styles into a HAML attribute. Obviously
  # use sparingly because you should probably be doing this through stylesheets.
  def style(**attributes)
    attributes.reduce("") do |string, (key, value)|
      name = key.to_s.gsub("_", "-")
      string << "#{name}: #{value}; "
    end
  end
end
