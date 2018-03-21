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
      # TODO: Use Warden so I can better deal with multiple strategies
      @current_user ||= (user_from_session_id || user_from_api_token)
    end

    def user_from_session_id
      return unless session.key? :user_id

      User.find_by_id(session[:user_id])
    end

    def user_from_api_token
      auth_header = request.headers["Authentication"]
      return unless auth_header

      kind, encoded_token = auth_header.split(" ")

      case kind
      when /apitoken/i
        return unless encoded_token
        ApiKey.find_and_authenticate(encoded_token)&.user
      else
        error "Invalid authentication type header. Must be 'Authentication: apitoken <token>'"
      end
    end

    def authenticate_user
      deny_access unless current_user
    end

    def deny_access
      session[:access_denied_url] = request.url
      redirect_to new_session_url
    end

    def access_denied_url
      session[:access_denied_url]
    end
end