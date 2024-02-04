# frozen_string_literal: true

class ApplicationLayout < ApplicationView
	include Phlex::Rails::Layout

	def initialize(title: "Thingybase")
		@title = title
	end

	def template(&block)
		doctype

		html do
			head do
				title { @title }
				meta name: "viewport", content: "width=device-width,initial-scale=1"
				meta charset: "utf-8"
				meta :"http-equiv" => "X-UA-Compatible", content: "IE=edge,chrome=1"
				meta name: "apple-mobile-web-app-capable", content: "yes"
				meta name: "apple-mobile-web-app-status-bar-style", content: "black-translucent"
				csp_meta_tag
				csrf_meta_tags
				stylesheet_link_tag "tailwind", data_turbo_track: "reload"
				javascript_importmap_tags
				helpers.opengraph_meta_tags
			end

			body do
				main(&block)
			end
		end
	end
end
