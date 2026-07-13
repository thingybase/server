require "rails_helper"

RSpec.describe "Webhooks::StripeWebhooks", type: :request do
  around do |example|
    ENV["STRIPE_SIGNING_SECRET"] = "whsec_test"
    example.run
  ensure
    ENV.delete("STRIPE_SIGNING_SECRET")
  end

  describe "POST /webhooks/stripe_webhook" do
    it "rejects payloads without a valid Stripe signature" do
      post webhooks_stripe_webhook_path,
        params: "{}",
        headers: { "CONTENT_TYPE" => "application/json", "HTTP_STRIPE_SIGNATURE" => "bogus" }
      expect(response).to have_http_status(:bad_request)
    end
  end
end
