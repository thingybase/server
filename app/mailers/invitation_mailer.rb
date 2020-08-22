class InvitationMailer < ApplicationMailer
  def account_invitation_email(invitation)
    @invitation = invitation
    mail(to: invitation.email, subject: "Invitation from #{invitation.user.name} to join Thingybase")
  end
end
