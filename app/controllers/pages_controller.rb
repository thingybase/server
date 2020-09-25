class PagesController < Sitepress::SiteController
  skip_security!
  before_action :set_current_page, only: :index
  before_action :assign_title, only: :show

  # Manually do this for now ... I should update Sitepress gem to handle this though.
  def index
    render_page current_page
  end

  private
    def assign_title
      @page_title = current_page.data.fetch("title")
    end

    def set_current_page
      # This is required to set the internal reference to `current_page`.
      @_current_page = site.root.formats.first
    end
end
