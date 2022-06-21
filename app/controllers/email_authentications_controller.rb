class EmailAuthenticationsController < NoPassword::EmailAuthenticationsController
  skip_security!
  layout "focused"

  private
    def verification_succeeded(email)
      rotate_session

      if user = User.find_by_email(email)
        self.current_user = user
        redirect_to launch_url
      else
        # Now set an authentic email for the next view.
        session[:authentic_email] = email
        redirect_to new_signup_url
      end
    end

    # Override with logic for when verification attempts are exceeded. For
    # example, you might want to tweak the flash message that's displayed
    # or redirect them to a page other than the one where they'd re-verify.
    def verification_exceeded_attempts(verification)
      flash[:nopassword_status] =  "The number of times the code can be tried has been exceeded."
      redirect_to url_for(action: :new)
    end

    # Override with logic for when verification has expired. For
    # example, you might want to tweak the flash message that's displayed
    # or redirect them to a page other than the one where they'd re-verify.
    def verification_expired(verification)
      flash[:nopassword_status] =  "The code has expired."
      redirect_to url_for(action: :new)
    end

    # Override with your own logic to deliver a code to the user.
    def deliver_authentication(authentication)
      NoPassword::EmailAuthenticationMailer.with(authentication: authentication).notification_email.deliver
    end
end
