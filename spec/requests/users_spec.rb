require "rails_helper"

RSpec.describe "Users", type: :request do
  let(:user) { create(:user, name: "Casey Tester") }

  before { sign_in user }

  describe "GET /users/:id" do
    it "shows the user's profile" do
      get user_path(user)
      expect(response.body).to include("Casey Tester")
    end
  end

  describe "PATCH /users/:id" do
    it "updates the profile" do
      patch user_path(user), params: { user: { name: "New Name", email: user.email } }
      expect(user.reload.name).to eq("New Name")
    end

    it "re-renders the edit form when invalid" do
      patch user_path(user), params: { user: { name: "", email: user.email } }
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it "cannot update another user" do
      other_user = create(:user, name: "Someone Else")
      patch user_path(other_user), params: { user: { name: "Hacked", email: other_user.email } }
      expect(other_user.reload.name).to eq("Someone Else")
    end
  end
end
