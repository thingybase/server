require "rails_helper"

RSpec.describe "Sign in", type: :request do
  describe "GET /session/new" do
    it "renders the sign-in page" do
      get new_session_path
      expect(response.body).to include("Continue to your account")
    end

    it "offers Google sign-in" do
      get new_session_path
      expect(response.body).to include("/auth/google_oauth2")
    end

    it "offers email sign-in" do
      get new_session_path
      expect(response.body).to include("Enter your email address")
    end
  end

  describe "POST /email_authentications" do
    it "accepts a valid email and shows the check-your-email page" do
      post email_authentications_path, params: { nopassword_email_authentication: { email: "brad@example.com" } }
      expect(response).to have_http_status(:accepted)
    end

    it "sends the sign-in link" do
      expect {
        post email_authentications_path, params: { nopassword_email_authentication: { email: "brad@example.com" } }
      }.to have_enqueued_mail(NoPassword::EmailAuthenticationMailer, :authentication_email)
    end

    it "rejects an invalid email" do
      post email_authentications_path, params: { nopassword_email_authentication: { email: "not-an-email" } }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe "GET /email_authentications/new" do
    it "renders the email sign-in page" do
      get new_email_authentication_path
      expect(response.body).to include("Get a sign-in link")
    end
  end
end
