class InvitationResponse < ApplicationModel
  attr_accessor :invitation, :status, :user, :token
  delegate :id, :account, to: :invitation

  STATUSES = {
    "Accept" => "accept",
    "Decline" => "decline"
  }

  validates :user, presence: true
  validates :invitation, presence: true
  validates :status, presence: true,
    inclusion: { in: STATUSES.values, message: "%{value} is not a valid response" }
  validate :matching_token

  def save
    transition_state if valid?
  end

  def accepted?
    status == "accept"
  end

  private
    def matching_token
      errors.add(:token) if token && token != invitation.token
    end

    def transition_state
      if STATUSES.values.include?(status)
        self.send(status)
      else
        raise "#{status} is an invalid state transition"
      end
    end

    def accept
      Account.transaction do
        invitation.account.members.find_or_create_by! user: user
        invitation.destroy
      end
    end

    def decline
      invitation.destroy
    end
end
