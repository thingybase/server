# Renders icons in various formats for various color modes.
# TODO: Add HTTP and server partial caching to this so that icons are rendered faster.
class IconsController < ApplicationController
  skip_security!

  def index
    @icons = Icon.all
  end
end
