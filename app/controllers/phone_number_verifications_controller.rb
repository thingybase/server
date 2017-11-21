class PhoneNumberVerificationsController < ResourcesController
  def self.resource
    PhoneNumberVerification
  end

  def permitted_params
    [:code]
  end

  def update_redirect_url
    @phone_number_verification.user
  end
end
