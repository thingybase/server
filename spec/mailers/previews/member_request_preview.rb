# Preview all emails at http://localhost:3000/rails/mailers/member_request
class MemberRequestPreview < ActionMailer::Preview
  def account_request_email
    request = MemberRequest.first
    MemberRequestMailer.account_request_email(request)
  end

  def account_approval_email
    member = Member.first
    approver = User.first
    MemberRequestMailer.account_approval_email(member, approver)
  end
end
