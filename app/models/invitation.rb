class Invitation < ApplicationRecord
  TOKEN_SIZE = 16
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

  def self.random_token
    SecureRandom.hex(TOKEN_SIZE)
  end

  def response
    @_response ||= InvitationResponse.new(invitation: self)
  end

  private
    def assign_random_token
      self.token ||= self.class.random_token
    end
end
