require 'rails_helper'

RSpec.describe "team_invitation_responses/show", type: :view do
  before(:each) do
    @team_invitation_response = assign(:team_invitation_response, TeamInvitationResponse.create!(
      :user => "",
      :team => ""
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
