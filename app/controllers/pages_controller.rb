class PagesController < Sitepress::SiteController
  skip_security!

  def index
    render layout: false
  end
end
