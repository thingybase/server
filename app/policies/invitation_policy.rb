class InvitationPolicy < BaseAccountOwnerPolicy
  def email?
    is_account_owner?
  end
end
