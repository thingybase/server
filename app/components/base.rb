# frozen_string_literal: true

class Components::Base < Phlex::HTML
  # Include any helpers you want to be available across all components
  include Phlex::Rails::Helpers::Routes
  include Phlex::Rails::Helpers::ImageTag
  include Phlex::Rails::Helpers::LinkTo
  include Phlex::Rails::Helpers::Pluralize

  include Superview::Helpers::Links

  if Rails.env.development?
    def before_template
      comment { "Before #{self.class.name}" }
      super
    end
  end

  def cache_store = Rails.cache
end
