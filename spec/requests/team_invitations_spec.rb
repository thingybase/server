require 'rails_helper'

RSpec.describe "TeamInvitations", type: :request do
  describe "GET /team_invitations" do
    it "works! (now write some real specs)" do
      get team_invitations_path
      expect(response).to have_http_status(200)
    end
  end
end
