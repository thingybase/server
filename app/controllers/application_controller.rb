class ApplicationController < ActionController::Base
  include Imageomatic::Opengraph
  include Featureomatic::Authorization
  include Authentication
  include Pundit

  before_action :authenticate_user
  after_action :verify_authorized, except: [:index]
  after_action :verify_policy_scoped, only: :index
  after_action :extend_session_expiration

  protect_from_forgery with: :exception, unless: :has_authentication_header?
  protect_from_forgery with: :null_session, if: :has_authentication_header?

  rescue_from Pundit::NotAuthorizedError, with: :request_forbidden
  rescue_from ActiveRecord::RecordNotFound, with: :request_not_found

  protected
    def request_forbidden(exception)
      @permission = humanized_permission exception.query
      @forbidden_resource = exception.record
      render "forbidden", layout: "application", status: :forbidden
    end

    def request_not_found
      render "not_found", layout: "application", status: :not_found
    end

    def current_plan
      @account&.plan
    end

    # Always carry over these session keys when rotated.
    ROTATE_SESSION_KEYS = [:access_denied_url]

    # Carries over a few session keys, but resets the session to prevent fixation attacks.
    # This is mainly used by user and account provisioning flows.
    def rotate_session(*keys)
      keys = Set.new(keys).merge(ROTATE_SESSION_KEYS)
      values = keys.map{ |key| session[key] }
      reset_session
      keys.zip(values).each { |key, value| session[key] = value if value }
    end

    # Disables user authentication and authorization for controlls that opt-out
    # of security. The default is that everything is locked down so that developers
    # have to opt-out of these protections.
    def self.skip_security!(**kwargs)
      skip_before_action :authenticate_user, **kwargs
      skip_after_action :verify_authorized, **kwargs.merge(except: :index)
      skip_after_action :verify_policy_scoped, **kwargs.merge(only: :index)
    end

  private
    def humanized_permission(query)
      case query
      when "show?"
        "view"
      when "update?", "edit?"
        "edit"
      when "create?", "new?"
        "create"
      else
        "access"
      end
    end

    # Keeps the cookie session alive until 30 days after the last users activity.
    def extend_session_expiration
      session[:expires_at] = session.options[:expire_after].from_now
    end
end
