class UserMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.welcome.subject
  #
  #
  layout false

  def welcome
    @greeting = "Hi"

    mailer Views::UserMailer::Welcome.new(User.first),
      to: "to@example.org"
  end
end
