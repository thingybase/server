class EmailCodeVerificationsController < ApplicationController
  skip_security!
  before_action :ensure_session_email

  def new
    @email_code_verification = EmailCodeVerification.new(session_params)
  end

  def create
    @email_code_verification = EmailCodeVerification.new(resource_params)

    if @email_code_verification.valid?
      redirect_to_signup_or_account @email_code_verification.email
    elsif @email_code_verification.exceeded_verification_attempts?
      redirect_to_new_user_resolution notice: "The code was invalidated after a few tries to keep it safe. Enter an email to get a new code."
    elsif @email_code_verification.exceeded_time_to_live?
      redirect_to_new_user_resolution notice: "The code was expired after a few minutes to keep it safe. Enter an email to get a new code."
    else
      # Update the session state so we can track remaining attempts to verify
      session[:email_code_verification] = @email_code_verification.serializeable_session_hash
      render "new", status: :unprocessable_entity
    end
  end

  private
    # If we find a user with this email, it's their account, so send them on their
    # way; otherwise lets send them to the signup path to create a new user.
    def redirect_to_signup_or_account(email)
      rotate_session
      if user = User.find_by_email(email)
        self.current_user = user
        redirect_to launch_accounts_url
      else
        # Now set an authentic email for the next view.
        session[:authentic_email] = @email_code_verification.email
        redirect_to new_signup_url
      end
    end

    # When something fails during email authentication, lets send the person back
    # to the screen where they can re-enter their email and start it over again.
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
