class PhoneNumberClaimsController < ResourcesController
  def self.resource
    PhoneNumberClaim
  end

  def permitted_params
    [:phone_number]
  end

  def create_redirect_url
    new_phone_number_claim_verification_url(@phone_number_claim)
  end
end
