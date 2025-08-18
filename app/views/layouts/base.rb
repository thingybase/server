# frozen_string_literal: true

class Views::Layouts::Base < Components::Base
  AUTHORIZED_HOSTS = %w[www.thingybase.com thingybase.com].freeze

	include Phlex::Rails::Layout
	include Phlex::Rails::Helpers::Request

	register_value_helper :opengraph_meta_tags

	attr_accessor :opengraph

	def initialize(title: "Thingybase", opengraph: OpenGraph.new)
		@title = title
		@opengraph = opengraph
	end

	class OpenGraph < Components::Base
	  attr_accessor :title, :description, :image_url

	  def initialize(title: nil, description: nil, image_url: nil)
  		@title = title
  		@description = description
  		@image_url = image_url
	  end

		def view_template
			meta property: "og:title", content: @title
			meta property: "og:description", content: @description
			meta property: "og:image", content: @image_url
			meta property: "twitter:title", content: @title
			meta property: "twitter:description", content: @description
			meta property: "twitter:image", content: @image_url
		end
	end

	def view_template(&content)
		doctype

		html do
			head do
				title { @title }
				meta name: "viewport", content: "width=device-width,initial-scale=1"
				meta charset: "utf-8"
				meta name: "apple-mobile-web-app-capable", content: "yes"
				meta name: "apple-mobile-web-app-status-bar-style", content: "black-translucent"
				csp_meta_tag
				csrf_meta_tags
				stylesheet_link_tag "tailwind", data_turbo_track: "reload"
				javascript_importmap_tags
				render @opengraph
			end

			body do
			  license_notice_template if unlicensed_use?
				main(&content)
			end
		end
	end

	def license_notice_template
		dialog(class: "bg-error/90 text-error-content p-8 rounded-xl max-w-prose z-20 fixed top-1/2 left-1/2 transform -translate-x-1/2 -translate-y-1/2 shadow-2xl space-y-4", open: true) do
			  h1(class: "text-2xl font-bold") { "Thingybase is a proprietary application" }
				p { "Thingybase has detected you may be running an unlicensed environment and is displaying the license." }
				textarea(class: "w-full min-h-[50vh] max-h-[96vh] textarea p-4", readonly: true){ File.read("LICENSE.md") }
				a(href: "https://github.com/thingybase/server", class: "btn btn-error btn-error-primary w-full"){ "View the Github repo"}
		end
	end

	def unlicensed_use?
	  Rails.env.production? and not AUTHORIZED_HOSTS.include?(request.host)
	end
end
