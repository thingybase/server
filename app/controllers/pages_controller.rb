class PagesController < Sitepress::SiteController
  skip_security!
  before_action :assign_title, only: :show
  layout "page"

  private
    def assign_title
      # @page_title = requested_resource.data.fetch("title")
    end
end
