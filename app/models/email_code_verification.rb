class EmailCodeVerification < ApplicationModel
  # Maximum number of times that a verification can be attempted.
  MAXIMUM_VERIFICATION_ATTEMPTS = 3

  # How long can the code live until it expires a new
  # code verification must be created
  TIME_TO_LIVE = 5.minutes

  # 6 digit random numeric code
  MAXIMUM_RANDOM_NUMBER = 999_999

  # Track the number of attempts made to verify the code.
  attr_accessor :verification_attempts
  validates :verification_attempts,
    presence: true,
    numericality: {
      only_integer: true,
      less_than: MAXIMUM_VERIFICATION_ATTEMPTS }

  attr_accessor :email
  validates :email,
    presence: true,
    format: { with: URI::MailTo::EMAIL_REGEXP }

  attr_accessor :expires_at
  validates :expires_at, presence: true
  validate :code_expiration

  attr_accessor :code_hash
  validates :code_hash, presence: true

  attr_accessor :code
  validates :code, presence: true
  validate :code_authenticity

  # This method returns the random code that should NOT
  # be persisted, but may be given to the user. A code_hash
  # is persisted, which is to be
  def generate_random_code
    self.code = self.class.random_code
    self.code_hash = BCrypt::Password.create(code)
  end

  def has_exceeded_verification_attempts?
    MAXIMUM_VERIFICATION_ATTEMPTS < verification_attempts
  end

  def has_expired?
    Time.now > expires_at
  end

  def serializeable_session_hash
    {
      email: email,
      verification_attempts: verification_attempts,
      expires_at: expires_at,
      code_hash: code_hash
    }
  end

  # Generates a random numeric code.
  def self.random_code
    SecureRandom.random_number MAXIMUM_RANDOM_NUMBER
  end

  def has_authentic_code?
    BCrypt::Password.new(code_hash) == code.to_i
  end

  private
    def assign_defaults
      self.expires_at ||= TIME_TO_LIVE.from_now
      self.verification_attempts ||= 0
    end

    def code_authenticity
      return if code_hash.nil?

      self.verification_attempts += 1
      errors.add(:code, "is not valid") unless has_authentic_code?
    end

    def code_expiration
      errors.add(:code, "has expired") if has_expired?
    end
end
