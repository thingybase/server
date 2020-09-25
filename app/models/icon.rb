class Icon < ApplicationModel
  attr_accessor :key
  delegate :name, :updated_at, to: :asset

  def asset
    @asset ||= VectorAsset.collection.find "icons/#{key}#{VectorAsset::EXTENSION}"
  end

  class << self
    def all(keys: all_keys)
      Enumerator.new do |y|
        keys.each do |key|
          y << Icon.new(key: key)
        end
      end
    end

    def find(key)
      Icon.new key: key
    end

    def exist?(key)
      keys.include? key
    end

    def keys
      @keys ||= Dir.glob(VectorAsset.collection.root.join("icons/**#{VectorAsset::EXTENSION}")).map{ |path| File.basename(path, VectorAsset::EXTENSION)}
    end
    alias :all_keys :keys
  end
end
