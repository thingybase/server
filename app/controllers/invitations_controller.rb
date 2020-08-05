class InvitationsController < ResourcesController
  include AccountLayout

  def email
    InvitationMailer.account_invitation_email(@invitation).deliver_now
    flash[:notice] = "Invitation sent to #{@invitation.email}"
    redirect_to account_invitations_path(@invitation.account)
  end

  private
    def self.resource
      Invitation
    end

    def resource_scope
      policy_scope.joins(:user)
    end

    def permitted_params
      [:email, :name, :token, :account_id]
    end

    def destroy_redirect_url
      @account ? account_invitations_url(@account) : invitations_url
    end

    def assign_attributes
      @invitation.user = current_user
      @invitation.account ||= @account
      @invitation.token ||= Invitation.random_token
    end
end
