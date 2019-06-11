require 'rails_helper'

RSpec.describe "invitation_responses/edit", type: :view do
  before(:each) do
    @invitation_response = assign(:invitation_response, InvitationResponse.create!(
      user: "",
      account: ""
    ))
  end

  it "renders the edit invitation_response form" do
    render

    assert_select "form[action=?][method=?]", invitation_response_path(@invitation_response), "post" do

      assert_select "input[name=?]", "invitation_response[user]"

      assert_select "input[name=?]", "invitation_response[account]"
    end
  end
end
