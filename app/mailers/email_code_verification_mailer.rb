class EmailCodeVerificationMailer < ApplicationMailer
  def verification_code_email(email_verification_code)
    @email_verification_code = email_verification_code
    mail(to: @email_verification_code.email, subject: "Thingybase login code")
  end
end
