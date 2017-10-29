class TeamInvitationResponse
  include ActiveModel::Model
  attr_accessor :invitation, :status, :user

  STATUSES = {
    "Accept" => "accept",
    "Decline" => "decline"
  }

  validates :user, presence: true
  validates :invitation, presence: true
  validates :status, presence: true,
    inclusion: { in: STATUSES.values, message: "%{value} is not a valid response" }

  def to_param
    invitation.token
  end

  def persisted?
    invitation.persisted?
  end

  def save
    transition_state if valid?
  end

  private
    def transition_state
      if STATUSES.values.include?(status)
        self.send(status)
      else
        raise "#{status} is an invalid state transition"
      end
    end

    def accept
      Team.transaction do
        invitation.team.members.find_or_create_by! user: user
        invitation.destroy
      end
    end

    def decline
      invitation.destroy
    end
end
