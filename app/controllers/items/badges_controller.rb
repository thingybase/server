# Renders a badge in HTML, which is converted to a .png by a third party service,
# for use in open graph URLs. Makes sharing links with people via iMessage, etc.
# much more visual and pleasant. For now the security of this displays just the
# title and icon. The link is hard to guess via the uuid, making it impractical
# for data leakage.
#
# To secure in the future, add an account-level setting that lets people turn
# this off or control what is shared so they are in full control.
module Items
  class BadgesController < ApplicationController
    skip_security!

    before_action :set_resource_instance_variable

    VIEWPORT_HEIGHT = 600
    VIEWPORT_WIDTH = 600

    def show
      respond_to do |format|
        format.html { render layout: false }
        format.png { redirect_to screenshot_url }
      end
    end

    protected
      def screenshot_url
        microlink_screenshot_url url: url_for(format: :html),
          "viewport.width": VIEWPORT_WIDTH,
          "viewport.height": VIEWPORT_HEIGHT,
          type: :png
      end

      def microlink_screenshot_url(**params)
        params[:screenshot]   ||= true
        params[:embed]        ||= "screenshot.url"

        URI("https://api.microlink.io/").tap do |url|
          url.query = params.to_query
        end.to_s
      end

      def self.parent_resource
        Item
      end

      def find_item
        Item.find_resource params[:item_id]
      end

      def set_resource_instance_variable
        @item = find_item
      end
  end
end
