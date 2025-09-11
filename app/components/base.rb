# frozen_string_literal: true

class Components::Base < Phlex::HTML
  # Include any helpers you want to be available across all components
  include Phlex::Rails::Helpers::Routes
  include Phlex::Rails::Helpers::ImageTag
  include Phlex::Rails::Helpers::LinkTo
  include Phlex::Rails::Helpers::Pluralize
  include Phlex::Rails::Helpers::TurboStreamFrom

  include Superview::Helpers::Links

  if Rails.env.development?
    def before_template
      comment { "Before #{self.class.name}" }
      super
    end
  end

  def block_name = nil

  def bem(element, modifier = nil)
    element = [block_name, element].join("__")
    modifier ? "#{element}--#{modifier}" : element
  end

  def subscribe
    turbo_stream_from dom_id if context.any?
  end

  def broadcast_replace(streamable = dom_id, target: dom_id)
    Turbo::StreamsChannel.broadcast_replace_to(streamable, target:, content: call)
  end

  def dom_id(*keys)
    self.class.name.downcase.split("::").append(*keys).join("_")
  end

  def cache_store = Rails.cache
end
