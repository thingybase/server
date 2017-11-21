class PhoneNumberVerification < ApplicationModel
  attr_accessor :claim, :code
  delegate :id, :user, :persisted?, to: :claim

  validates :code, presence: true
  validates :claim, presence: true
  validate :matching_code

  def save
    assign_phone_number_to_user if valid?
  end

  def self.find(id)
    claim = PhoneNumberClaim.find(id)
    new claim: claim
  end

  private
    def assign_phone_number_to_user
      User.transaction do
        # Find a user with this phone number and set nil
        User.where(phone_number: claim.phone_number).each do |user|
          user.update_attribute(:phone_number, nil)
          # TODO: Notify the user their phone number was claimed (and to email if
          # they think this is a security break type of issue)
          # That's why I loop through these objects. There should only ever be one
          # so I'm not worried about performance here...
        end
        # Now assign the phone number to the user who is making the claim.
        claim.user.update_attributes! phone_number: claim.phone_number
        claim.destroy
      end
    end

    def matching_code
      errors.add(:code) if claim&.code.nil? || code.nil? || claim.code != code
    end
end
