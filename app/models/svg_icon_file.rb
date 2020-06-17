class SvgIconFile < ApplicationModel
  attr_accessor :key
  validates :key, presence: true

  IconNotFound = Class.new(RuntimeError)

  def icon_path
    self.class.icon_path_by_key(key)
  end

  def light_svg
    File.open icon_path
  end

  def name
    key.underscore.humanize
  end

  def dark_svg
    @_dark_svg ||= File.open(icon_path) do |file|
      Nokogiri::XML(file).tap do |svg|
        svg.css("path[fill]").attr("fill", "#fff")
      end
    end
  end

  def persisted?
    icon_path.exist?
  end

  def cache_key(*segments)
    File.join(model_name.singular, [ key, fingerprint ].join("-"), *segments)
  end

  def fingerprint
    @_fingerprint ||= Digest::MD5.hexdigest(light_svg.read)
  end

  def updated_at
    File.mtime icon_path
  end

  def to_param
    [key, fingerprint].join("-")
  end

  private
    def self.root_path
      Rails.root.join("app/icons")
    end

    def self.icon_path_by_key(key)
      root_path.join([key, "svg"].join("."))
    end

    def self.find(key)
      icon = new(key: key)
      raise IconNotFound unless icon.persisted?
      icon
    end

    def self.paths
      root_path.glob("*.svg")
    end

    def self.keys
      paths.map{ |path| path.basename(".svg").to_s }
    end

    def self.all
      Enumerator.new do |y|
        keys.each do |key|
          y << new(key: key)
        end
      end
    end
end
