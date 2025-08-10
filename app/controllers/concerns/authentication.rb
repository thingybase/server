module Authentication
  extend ActiveSupport::Concern

  AUTHENTICATION_HEADER_KEY = "Authentication".freeze

  included do
    helper_method :current_user, :logged_in?
  end

  protected
    def authenticate_user
      deny_access unless current_user
    end

    def access_denied
      respond_to do |format|
        format.opengraph { deny_opengraph_format }
        format.any { deny_any_format }
      end
    end

    # This is broken out so that it can be overridden by controllers
    # that need to do something special for the badge.
    def deny_opengraph_format
      render :unauthorized, layout: "application"
    end

    def deny_any_format
      render :unauthorized, layout: "application", status: :unauthorized, formats: :html
    end

  private
    def logged_in?
      current_user
    end

    def current_user=(user)
      session[:user_id] = user.id
    end

    def current_user
      # TODO: Use Warden so I can better deal with multiple strategies
      @current_user ||= user_from_session_id
    end

    def user_from_session_id
      return unless session.key? :user_id

      User.find_by_id(session[:user_id])
    end



    def deny_access
      session[:access_denied_url] = request.url
      access_denied
    end

    def access_denied_url
      session[:access_denied_url]
    end


end