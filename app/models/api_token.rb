class ApiToken < ApplicationRecord
  ACCESS_ID_LENGTH = 24
  ACCESS_KEY_LENGTH = 64

  belongs_to :user

  validates :user, presence: true
  validates :access_id,
    presence: true,
    uniqueness: true,
    password_strength: { min_entropy: ACCESS_ID_LENGTH }
  validates :access_key,
    presence: true,
    password_strength: { min_entropy: ACCESS_KEY_LENGTH }

  def self.generate_access_id
    SecureRandom.urlsafe_base64(ACCESS_ID_LENGTH)
  end

  def self.generate_access_key
    SecureRandom.urlsafe_base64(ACCESS_KEY_LENGTH)
  end

  def self.find_and_authenticate(encoded_token)
    payload = JSON.parse Base64.decode64 encoded_token
    api_key = find_by_access_id payload['access_id']
    api_key if api_key&.authentic? payload['access_key']
  end

  def authentic?(unauthenticated_access_key)
    self if access_key == unauthenticated_access_key
  end

  def encode_token
    Base64.encode64 JSON.generate(access_id: access_id, access_key: access_key)
  end
end
