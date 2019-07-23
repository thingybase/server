class PagesController < ApplicationController
  skip_before_action :authenticate_user
  skip_after_action :verify_authorized
  skip_after_action :verify_policy_scoped

  def index
    render layout: false
  end
end
