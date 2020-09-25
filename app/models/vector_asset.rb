# Manipulates SVG files and gives paths.
class VectorAsset < ApplicationModel
  attr_accessor :path, :key
  validates :path, presence: true

  AssetNotFound = Class.new(RuntimeError)

  TRANSFORMABLE_ATTRIBUTES = %w[fill stroke]

  EXTENSION = ".svg".freeze

  def name
    Pathname.new(path).basename.sub_ext("").to_s.underscore.humanize
  end

  def svg
    @svg ||= File.read path
  end

  def hsl(hue = nil, saturation = nil, luminosity = nil)
    color_attributes.each do |color|
      color.hue = hue.to_f if hue
      color.saturation = saturation.to_f if saturation
      color.luminosity = luminosity.to_f if luminosity
    end
  end

  def persisted?
    File.exist? path
  end

  def cache_key(*segments)
    File.join(model_name.singular, fingerprint_key, *segments)
  end

  def fingerprint
    @fingerprint ||= Digest::MD5.hexdigest(svg)
  end

  def updated_at
    File.mtime path
  end

  def to_param
    fingerprint_key
  end

  def fingerprint_key
    basename = File.basename(key, EXTENSION)
    fingerprint_basename = "#{basename}-#{fingerprint}#{EXTENSION}"
    File.join File.dirname(key), fingerprint_basename
  end

  def color_attributes
    Enumerator.new do |y|
      Nokogiri::XML(svg).tap do |doc|
        TRANSFORMABLE_ATTRIBUTES.each do |attr|
          doc.css("[#{attr}]").each do |el|
            # Get the original value
            value = el.attr(attr)
            next if value == "none"
            # Transform the color
            color = Color.new(el.attr(attr)).to_hsl
            y << color
            # Then apply it
            el.set_attribute(attr, color.html)
          end
        end
      end
    end
  end

  class << self
    delegate :find, :find!, to: :collection

    def collection
      @collection ||= FileCollection.new root: Rails.root.join("app/assets/vectors")
    end
  end
  # All of the goo needed to find the SVG file in a directory and pull it
  # VectorAsset objects.
  class FileCollection
    attr_accessor :root

    def initialize(root:)
      @root = root
    end

    def find(path)
      full_path = @root.join(path)
      return nil unless exist? full_path
      VectorAsset.new(path: full_path, key: key(full_path))
    end

    def find!(path)
      find(path) || raise(AssetNotFound)
    end

    def exist?(path)
      File.exist? path
    end

    def all
      glob("**/*#{EXTENSION}")
    end

    def glob(pattern)
      root.glob(glob).map { |path| VectorAsset.new(path: path, key: key(path)) }
    end

    def key(path)
      Pathname.new(path).relative_path_from(root).to_s
    end
  end
end
