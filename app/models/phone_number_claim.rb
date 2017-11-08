class PhoneNumberClaim < ApplicationRecord
  CODE_LENGTH = 8

  belongs_to :user

  phony_normalize :phone_number, default_country_code: 'US'
  validates :phone_number, phony_plausible: true, presence: true
  validates :code,
    presence: true,
    length: { is: CODE_LENGTH }
  validates :user, presence: true
  before_validation :assign_random_code


  def verification(**attributes)
    attributes[:claim] = self
    PhoneNumberVerification.new(**attributes)
  end

  # Generates a random number with padded 0's `length` digits long.
  def self.random_code(length: CODE_LENGTH)
    "%0#{length}d" % SecureRandom.random_number(("9"*length).to_i)
  end

  private
    def assign_random_code
      self.code ||= self.class.random_code
    end
end
