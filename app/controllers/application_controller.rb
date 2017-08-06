class ApplicationController < ActionController::Base
  include Pundit
  # TODO: Turn this one when I scope things.
  after_action :verify_authorized, except: [:index, :create, :new]
  after_action :verify_policy_scoped, only: :index
  before_action :authenticate_user

  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?

  private
  def logged_in?
    current_user
  end

  def current_user=(user)
    session["user_id"] = user.id
  end

  def current_user
    @current_user ||= User.find_by_id(session["user_id"])
  end

  def authenticate_user
    access_denied unless current_user
  end

  def access_denied
    redirect_to new_session_url
  end
end
