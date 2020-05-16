class PagesController < ApplicationController
  skip_security!

  def index
    render layout: false
  end
end
