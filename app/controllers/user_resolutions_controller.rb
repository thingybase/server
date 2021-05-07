class UserResolutionsController < ApplicationController
  skip_security!
  layout "focused"

  def new
    @user_resolution = UserResolution.new
  end

  def create
    @user_resolution = UserResolution.new(resource_params)

    if @user_resolution.valid?
      # TODO: Implement a password/SSO flows here when that is further along; for
      #   now we'll just authenticate the user via the code we email them.
      # if @user_resolution.persisted?
      #   redirect_to new_session_url
      # else
        email_code_verification = EmailCodeVerification.new(email: resource_params.fetch(:email))
        email_code_verification.generate_random_code

        EmailCodeVerificationMailer.verification_code_email(email_code_verification).deliver_now

        rotate_session
        session[:email_code_verification] = email_code_verification.serializeable_session_hash
        redirect_to new_email_code_verification_url
      # end
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def resource_params
      params.require(:user_resolution).permit(:email)
    end
end
