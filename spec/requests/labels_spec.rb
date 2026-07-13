require "rails_helper"

RSpec.describe "Labels", type: :request do
  let(:user) { create(:user) }
  let(:account) { create(:account, user: user) }
  let(:item) { create(:item, account: account, user: user) }

  before { sign_in user }

  describe "GET /labels/:id/scan" do
    it "redirects a scanned QR code to its item" do
      get scan_label_path(item.label)
      expect(response).to redirect_to(item_path(item))
    end
  end

  describe "GET /labels/:id" do
    it "redirects to the standard label" do
      get label_path(item.label)
      expect(response).to redirect_to(label_standard_url(item.label))
    end
  end
end
