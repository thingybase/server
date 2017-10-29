class TeamInvitation < ApplicationRecord
  TOKEN_SIZE = 16
  INVITATION_TTL = 3.days
  MINIMUM_ENTROPY = 30

  belongs_to :team
  belongs_to :user

  validates :email, presence: true
  validates :token, presence: true,
    uniqueness: true,
    password_strength: { min_entropy: MINIMUM_ENTROPY }
  validates :user, presence: true
  validates :team, presence: true

  before_validation :assign_random_token, on: :create
  before_validation :assign_default_expiration, on: :create

  def expired?
    expires_at > Time.now
  end

  def self.random_token
    SecureRandom.hex(TOKEN_SIZE)
  end

  private
    def assign_random_token
      self.token ||= self.class.random_token
    end

    def assign_default_expiration
      self.expires_at ||= INVITATION_TTL.from_now
    end
end
