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

  private
    def logged_in?
      current_user
    end

    def current_user=(user)
      session[:user_id] = user.id
    end

    def current_user
      # TODO: Use Warden so I can better deal with multiple strategies
      @current_user ||= (user_from_session_id || user_from_api_token)
    end

    def user_from_session_id
      return unless session.key? :user_id

      User.find_by_id(session[:user_id])
    end

    def user_from_api_token
      token = authentication_header
      return unless token

      kind, encoded_token = token.split(" ")

      case kind
      when /apitoken/i
        return unless encoded_token
        ApiKey.find_and_authenticate(encoded_token)&.user
      else
        error "Invalid authentication type header. Must be '#{AUTHENTICATION_HEADER_KEY}: apitoken <token>'"
      end
    end

    def deny_access
      session[:access_denied_url] = request.url
      render :unauthorized
    end

    def access_denied_url
      session[:access_denied_url]
    end

    def has_authentication_header?
      request.headers.key? AUTHENTICATION_HEADER_KEY
    end

    def authentication_header
      request.headers[AUTHENTICATION_HEADER_KEY]
    end
end