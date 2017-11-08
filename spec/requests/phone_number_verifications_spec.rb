require 'rails_helper'

RSpec.describe "PhoneNumberVerifications", type: :request do
  describe "GET /phone_number_verifications" do
    it "works! (now write some real specs)" do
      get phone_number_verifications_path
      expect(response).to have_http_status(200)
    end
  end
end
