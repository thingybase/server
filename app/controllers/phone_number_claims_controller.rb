class PhoneNumberClaimsController < ResourcesController
  after_action :send_claim_code, only: :create

  def self.resource
    PhoneNumberClaim
  end

  def permitted_params
    [:phone_number]
  end

  def create_redirect_url
    new_phone_number_claim_verification_url(@phone_number_claim)
  end

  private
    def create_notice
      nil
    end

    def send_claim_code
      # TODO: Assert this happens and move this to a better place in the code.
      SendClaimCodeSmsJob.perform_later resource if resource.valid?
    end
end
