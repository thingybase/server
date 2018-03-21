class ApplicationController < ActionController::Base
  include Authentication
  include Pundit

  after_action :verify_authorized, except: [:index]
  after_action :verify_policy_scoped, only: :index

  # TODO: Is this secure? I think I need to nullify the session for API calls.
  protect_from_forgery with: :exception, unless: :has_authentication_header?
  protect_from_forgery with: :null_session, if: :has_authentication_header?

  private
    def has_authentication_header?
      request.headers.key? "Authentication"
    end
end
