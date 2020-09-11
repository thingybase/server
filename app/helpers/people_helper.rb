module PeopleHelper
  def account_invitation_email_body
    render partial: "email_template", locals: {
      url: new_account_member_request_url(@account)
    }
  end
end
