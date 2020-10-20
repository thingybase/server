# Preview all emails at http://localhost:3000/rails/mailers/account_template
class AccountTemplatePreview < ActionMailer::Preview
  delegate :home_welcome_email, :home_invite_users_email, to: :mailer

  private
    def mailer
      AccountTemplateMailer.with(account: Account.first)
    end
end
