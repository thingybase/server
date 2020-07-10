# Manipulates SVG files and gives paths.
class SvgIconFile < ApplicationModel
  attr_accessor :key, :path
  validates :path, presence: true

  IconNotFound = Class.new(RuntimeError)

  def name
    key.underscore.humanize
  end

  def svg
    @_svg ||= File.read path
  end
  alias :light_svg :svg

  def key
    @key || path.basename(".svg").to_s
  end

  def dark_svg
    @_dark_svg ||= Nokogiri::XML(svg).tap do |doc|
      doc.css("path[fill]").attr("fill", "#fff")
    end.to_xml
  end

  def persisted?
    File.exist? path
  end

  def cache_key(*segments)
    File.join(model_name.singular, [ key, fingerprint ].join("-"), *segments)
  end

  def fingerprint
    @_fingerprint ||= Digest::MD5.hexdigest(light_svg)
  end

  def updated_at
    File.mtime path
  end

  def to_param
    [key, fingerprint].join("-")
  end

  class << self
    delegate :find,
        :find!,
        :all,
        :where,
        :exist?,
      to: :collection

    private
      def collection
        @_collection ||= FileCollection.new
      end
  end

  # All of the goo needed to find the SVG file in a directory and pull it
  # SvgIconFile objects.
  class FileCollection
    attr_accessor :path

    def initialize(path=nil)
      @path ||= Rails.root.join("app/icons")
    end

    def find(key)
      return nil unless exist? key
      SvgIconFile.new(key: key, path: icon_path_by_key(key))
    end

    def find!(key)
      find(key) || raise(IconNotFound)
    end

    def where(key:)
      key.map{ |key| find key }.compact
    end

    def exist?(key)
      File.exist? icon_path_by_key(key)
    end

    def all
      paths.map { |path| SvgIconFile.new(path: path) }
    end

    private
      def paths
        path.glob("*.svg")
      end

      def icon_path_by_key(key)
        path.join([key, "svg"].join("."))
      end
  end
end
