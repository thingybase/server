class ApplicationController < ActionController::Base
  include Pundit
  # TODO: Turn this one when I scope things.
  # after_action :verify_authorized

  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?

  private
  def current_user=(user)
    session["user_id"] = user.id
  end

  def current_user
    @current_user ||= User.find_by_id(session["user_id"])
  end

  def logged_in?
    !!@current_user
  end
end
