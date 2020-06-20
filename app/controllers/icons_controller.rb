# Renders icons in various formats for various color modes.
# TODO: Add HTTP and server partial caching to this so that icons are rendered faster.
class IconsController < ApplicationController
  skip_security!

  before_action :load_icon, except: :index

  rescue_from SvgIconFile::IconNotFound, with: :request_not_found

  def index
    @icons = SvgIconFile.all.to_a
  end

  def light
    cached_respond_to do |format|
      format.svg do
        render xml: cache_rendition { @icon.light_svg.read }
      end
    end
  end

  def dark
    cached_respond_to do |format|
      format.svg do
        render xml: cache_rendition { @icon.dark_svg.to_s }
      end
    end
  end

  private
    def permitted_params
      key, _, fingerprint = params[:id].rpartition("-")
      Hash[key: key, fingerprint: fingerprint]
    end

    def cached_respond_to(&block)
      http_cache_forever(public: true) do
        respond_to(&block)
      end
    end

    def cache_rendition(&block)
      cache @icon.cache_key(action_name, request.format) do
        block.call
      end
    end

    def load_icon
      @icon = SvgIconFile.find! permitted_params.fetch(:key)
    end
end
