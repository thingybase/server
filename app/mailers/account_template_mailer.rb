class AccountTemplateMailer < ApplicationMailer
  before_action :assign_instance_variables

  def home_welcome_email
    mail(to: @user.email, subject: "Welcome to your #{@account.name} account")
  end

  def home_invite_users_email
    mail(to: @user.email, subject: "Join my #{@account.name} account")
  end

  private
    def assign_instance_variables
      @account = params[:account]
      @user = @account.user
    end
end
