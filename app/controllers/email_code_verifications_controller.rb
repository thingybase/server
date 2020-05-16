class EmailCodeVerificationsController < ApplicationController
  skip_security!
  before_action :ensure_session_email

  def new
    @email_code_verification = EmailCodeVerification.new(session_params)
  end

  def create
    @email_code_verification = EmailCodeVerification.new(resource_params)

    if @email_code_verification.valid?
      rotate_session
      # TODO: Set a session variable with the email address, name, etc. and send the person
      # to the new user controller.

      raise "you are IN my friend!"

    elsif @email_code_verification.exceeded_verification_attempts?
      redirect_to_new_user_resolution notice: "The code was invalidated after a few tries to keep it safe. Enter an email to get a new code."
    elsif @email_code_verification.exceeded_time_to_live?
      redirect_to_new_user_resolution notice: "The code was expired after a few minutes to keep it safe. Enter an email to get a new code."
    else
      # Update the session state so we can track remaining attempts to verify
      session[:email_code_verification] = @email_code_verification.serializeable_session_hash
      render "new"
    end
  end

  private
    def redirect_to_new_user_resolution(notice:)
      rotate_session
      flash[:notice] = notice
      redirect_to new_user_resolution_url
    end

    def resource_params
      session_params.merge permitted_params
    end

    def permitted_params
      params.require(:email_code_verification).permit(:code)
    end

    def session_params
      session[:email_code_verification]
    end

    def ensure_session_email
      redirect_to new_user_resolution_url unless session_params&.key? "email"
    end
end
