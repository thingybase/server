class PhoneNumberClaimsController < ResourcesController
  def self.resource
    PhoneNumberClaim
  end

  def permitted_params
    [:phone_number]
  end

  def create_redirect_url
    [:edit, @phone_number_claim.verification]
  end
end
