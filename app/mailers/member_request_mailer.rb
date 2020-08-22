class MemberRequestMailer < ApplicationMailer
  def account_request_email(request)
    @member_request = request
    mail(to: @member_request.account.user.email, subject: "#{@member_request.user.name} requests to join your account")
  end

  def account_approval_email(member, approver)
    @member = member
    @approver = approver
    mail(to: @member.user.email, subject: "You have been approved to join the #{@member.account.name} Thingybase account")
  end
end
