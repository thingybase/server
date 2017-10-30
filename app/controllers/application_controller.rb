class ApplicationController < ActionController::Base
  include Authentication
  include Pundit

  after_action :verify_authorized, except: [:index]
  after_action :verify_policy_scoped, only: :index

  protect_from_forgery with: :exception
end
