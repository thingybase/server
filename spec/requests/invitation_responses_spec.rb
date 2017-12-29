require 'rails_helper'

RSpec.describe "InvitationResponses", type: :request do
  describe "GET /invitation_responses" do
    it "works! (now write some real specs)" do
      get invitation_responses_path
      expect(response).to have_http_status(200)
    end
  end
end
