# Renders icons in various formats for various color modes.
# TODO: Add HTTP and server partial caching to this so that icons are rendered faster.
class IconsController < ApplicationController
  skip_security!

  before_action :load_icon

  def light
    respond_to do |format|
      format.svg do
        render xml: cache_rendition { @icon.light_svg.read }
      end
    end
  end

  def dark
    respond_to do |format|
      format.svg do
        render xml: cache_rendition { @icon.dark_svg.to_s }
      end
    end
  end

  private
    def cache_rendition(&block)
      cache @icon.cache_key(action_name, request.format) do
        block.call
      end
    end

    def load_icon
      @icon = SvgIconFile.find params.fetch(:id)
    end
end
