require 'rails_helper'

RSpec.describe "TeamInvitationResponses", type: :request do
  describe "GET /team_invitation_responses" do
    it "works! (now write some real specs)" do
      get team_invitation_responses_path
      expect(response).to have_http_status(200)
    end
  end
end
