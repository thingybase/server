# frozen_string_literal: true

class ApplicationComponent < Phlex::HTML
	include Phlex::Rails::Helpers::Routes
	include Phlex::Rails::Helpers::LinkTo
	include Phlex::Rails::Helpers::ImageTag
	include Phlex::Rails::Helpers::Pluralize
	include Phlex::Rails::Helpers::URLFor

	include Superview::Helpers::Links

	if Rails.env.development?
		def before_template
			comment { "Before #{self.class.name}" }
			super
		end
	end
end
