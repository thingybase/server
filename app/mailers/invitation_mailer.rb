class InvitationMailer < ApplicationMailer
  def team_invitation_email(invitation)
    @invitation = invitation
    @salutation = ["Hi", invitation.name].join(" ")
    mail(to: @invitation.email, subject: "Invitation from #{invitation.user.name} to join Thingybase")
  end
end
