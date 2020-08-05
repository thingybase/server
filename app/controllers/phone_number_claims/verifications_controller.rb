module PhoneNumberClaims
  class VerificationsController < NestedResourcesController
    def self.resource
      PhoneNumberVerification
    end

    def self.parent_resource
      PhoneNumberClaim
    end

    def create
      super
    end

    private
      def create_notice
        "Phone number successfully verified"
      end

      def assign_attributes
        resource.claim = parent_resource
      end

      def permitted_params
        [:code]
      end

      def create_redirect_url
        @phone_number_verification.user
      end
  end
end
