require "rails_helper"

RSpec.describe "Authentication", type: :request do
  let(:user) { create(:user) }
  let(:account) { create(:account, user: user) }

  describe "anonymous access" do
    it "is denied for protected pages" do
      get account_items_path(account)
      expect(response).to have_http_status(:unauthorized)
    end

    it "is denied for index pages without blowing up on OpenGraph tags" do
      get items_path
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe "signing in through the OAuth callback" do
    it "redirects to launch" do
      sign_in user
      expect(response).to redirect_to(launch_url)
    end

    it "grants access to protected pages" do
      sign_in user
      get account_items_path(account)
      expect(response).to have_http_status(:ok)
    end
  end

  describe "signing out" do
    before { sign_in user }

    it "redirects to the root page" do
      delete session_path
      expect(response).to redirect_to(root_url)
    end

    it "revokes access to protected pages" do
      delete session_path
      get account_items_path(account)
      expect(response).to have_http_status(:unauthorized)
    end
  end
end
