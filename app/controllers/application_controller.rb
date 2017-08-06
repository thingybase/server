class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception
  helper_method :current_user

  private
  def current_user=(user)
    session["user_id"] = user.id
  end

  def current_user
    User.find session["user_id"]
  end
end
