class ApiKey < ApplicationRecord
  # These values were pulled out of my butt. They're probably too
  # long, but whatever.
  SECRET_KEY_LENGTH = 64

  TOKEN_ENCRYPTION_ALGORITH = 'HS256'.freeze
  TOKEN_SECRET = Rails.application.secrets.fetch(:secret_key_base)

  belongs_to :user

  validates :user, presence: true
  validates :name, presence: true
  validates :secret,
    presence: true,
    password_strength: { min_entropy: SECRET_KEY_LENGTH }

  before_validation :assign_generated_secret, on: :create

  def token
    payload = { data: token_payload }
    token = JWT.encode payload, TOKEN_SECRET, TOKEN_ENCRYPTION_ALGORITH
  end

  def self.generate_access_id
    SecureRandom.urlsafe_base64(ACCESS_ID_LENGTH)
  end

  def self.generate_secret
    SecureRandom.urlsafe_base64(SECRET_KEY_LENGTH)
  end

  # TODO: Move this complexity into a class that manages
  # deserializeing and authenticating the payload.
  def self.find_and_authenticate(token)
    payload, meta = JWT.decode token, TOKEN_SECRET, true, { algorithm: TOKEN_ENCRYPTION_ALGORITH }
    data = payload.fetch("data")
    api_key = find_by_id data.fetch("id")
    api_key if api_key&.authentic? data.fetch("secret")
  rescue JWT::DecodeError
    nil
  end

  def authentic?(unauthenticated_secret)
    secret == unauthenticated_secret
  end

  private
    def token_payload
      {
        id: id,
        secret: secret
      }
    end

    def assign_generated_secret
      self.secret ||= self.class.generate_secret
    end

    def assign_default_name
      self.name ||= "API key generated at #{Time.current} by #{user.name}"
    end
end
