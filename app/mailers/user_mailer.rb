class UserMailer < ApplicationMailer
  layout false

  def welcome
    @user = User.first

    mailer Views::UserMailer::Welcome.new(@user),
      to: @user.email
  end
end
