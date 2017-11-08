require 'rails_helper'

RSpec.describe "PhoneNumberClaims", type: :request do
  describe "GET /phone_number_claims" do
    it "works! (now write some real specs)" do
      get phone_number_claims_path
      expect(response).to have_http_status(200)
    end
  end
end
