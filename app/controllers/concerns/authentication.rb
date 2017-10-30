module Authentication
  extend ActiveSupport::Concern

  included do
    before_action :authenticate_user
    helper_method :current_user, :logged_in?
  end

  private
    def logged_in?
      current_user
    end

    def current_user=(user)
      session[:user_id] = user.id
    end

    def current_user
      @current_user ||= User.find_by_id(session[:user_id])
    end

    def authenticate_user
      deny_access unless current_user
    end

    def deny_access
      session[:access_denied_url] = request.url
      redirect_to new_session_url
    end

    def access_denied_url
      session.fetch[:access_denied_url]
    end
end