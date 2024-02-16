class MagesController < ApplicationController
  # Start with the site.
  def site(path = "./app/content/pages")
    Sitepress::Site.new(path)
  end

  # How do we get here?
  def show
    raise site.root_path.inspect
  end
end