class ApplicationController < ActionController::Base
  include Authentication
  include Pundit

  after_action :verify_authorized, except: [:index]
  after_action :verify_policy_scoped, only: :index

  protect_from_forgery with: :exception, unless: :has_authentication_header?
  protect_from_forgery with: :null_session, if: :has_authentication_header?

  rescue_from Pundit::NotAuthorizedError, with: :request_unauthorized
  rescue_from ActiveRecord::RecordNotFound, with: :request_not_found

  protected
    def request_unauthorized(exception)
      @permission = humanized_permission exception.query
      render "unauthorized", layout: "application", status: :unauthorized
    end

    def request_not_found
      render "not_found", layout: "application", status: :not_found
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
end
