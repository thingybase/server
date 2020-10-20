# Preview all emails at http://localhost:3000/rails/mailers/email_code_verification
class EmailCodeVerificationPreview < ActionMailer::Preview
  def verification_code_email
    code = EmailCodeVerification.new
    code.generate_random_code
    EmailCodeVerificationMailer.verification_code_email(code)
  end
end
