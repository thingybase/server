require 'rails_helper'

RSpec.describe "team_invitation_responses/index", type: :view do
  before(:each) do
    assign(:team_invitation_responses, [
      TeamInvitationResponse.create!(
        :user => "",
        :team => ""
      ),
      TeamInvitationResponse.create!(
        :user => "",
        :team => ""
      )
    ])
  end

  it "renders a list of team_invitation_responses" do
    render
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
  end
end
