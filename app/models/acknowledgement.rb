class Acknowledgement < ApplicationRecord
  belongs_to :user
  belongs_to :notification

  validates :user, presence: true
  validates_uniqueness_of :user_id, scope: :notification_id
  validates :notification, presence: true

  CLAIM_SECRET = 'my$ecretK3y'.freeze
  CLAIM_ENCRYPTION_ALGORITH = 'HS256'.freeze
  CLAIM_TTL = 10.minutes

  # Encode the acknowledgement into a format that can be stuck in a URL for Twilio
  # to eventually resolve a voice call w/
  def to_claim
    exp = Time.now.to_i + CLAIM_TTL
    exp_payload = { :data => to_json, :exp => exp }
    token = JWT.encode exp_payload, CLAIM_SECRET, CLAIM_ENCRYPTION_ALGORITH
  end

  # This will grab a claim from the notification system and include it
  def self.from_claim(token)
    # add leeway to ensure the token is still accepted
    payload, meta = JWT.decode token, CLAIM_SECRET, true, { exp_leeway: 30, algorithm: CLAIM_ENCRYPTION_ALGORITH }
    new JSON.parse payload.fetch("data")
  end
end
