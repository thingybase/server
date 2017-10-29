require 'rails_helper'

RSpec.describe "team_invitation_responses/new", type: :view do
  before(:each) do
    assign(:team_invitation_response, TeamInvitationResponse.new(
      :user => "",
      :team => ""
    ))
  end

  it "renders new team_invitation_response form" do
    render

    assert_select "form[action=?][method=?]", team_invitation_responses_path, "post" do

      assert_select "input[name=?]", "team_invitation_response[user]"

      assert_select "input[name=?]", "team_invitation_response[team]"
    end
  end
end
