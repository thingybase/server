class UserMailer < ApplicationMailer
  layout false

  def welcome(user)
    @user = user

    mailer Views::UserMailer::Welcome.new(@user),
      to: @user.email
  end
end
