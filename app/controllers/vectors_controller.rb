# Renders icons in various formats for various color modes.
class VectorsController < ApplicationController
  skip_security!

  before_action :load_asset

  rescue_from VectorAsset::AssetNotFound, with: :request_not_found

  def hsl
    cached_respond_to do |format|
      format.svg do
        render xml: cache_rendition { @icon.hsl(permitted_params[:h], permitted_params[:s], permitted_params[:l]) }
      end
    end
  end

  private
    def permitted_params
      id, _, fingerprint = params[:id].rpartition("-")
      params.permit(:h, :s, :l, :id, :fingerprint).merge(id: id, fingerprint: fingerprint)
    end

    def cached_respond_to(&block)
      http_cache_forever(public: true) do
        respond_to(&block)
      end
    end

    def cache_rendition(&block)
      cache @icon.cache_key(permitted_params[:h], permitted_params[:s], permitted_params[:l], request.format), &block
    end

    def load_asset
      @icon = VectorAsset.collection.find! "#{permitted_params.fetch(:id)}#{VectorAsset::EXTENSION}"
    end
end
