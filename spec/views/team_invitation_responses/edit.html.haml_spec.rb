require 'rails_helper'

RSpec.describe "team_invitation_responses/edit", type: :view do
  before(:each) do
    @team_invitation_response = assign(:team_invitation_response, TeamInvitationResponse.create!(
      :user => "",
      :team => ""
    ))
  end

  it "renders the edit team_invitation_response form" do
    render

    assert_select "form[action=?][method=?]", team_invitation_response_path(@team_invitation_response), "post" do

      assert_select "input[name=?]", "team_invitation_response[user]"

      assert_select "input[name=?]", "team_invitation_response[team]"
    end
  end
end
