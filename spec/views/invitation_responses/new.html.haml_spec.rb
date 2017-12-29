require 'rails_helper'

RSpec.describe "invitation_responses/new", type: :view do
  before(:each) do
    assign(:invitation_response, InvitationResponse.new(
      :user => "",
      :team => ""
    ))
  end

  it "renders new invitation_response form" do
    render

    assert_select "form[action=?][method=?]", invitation_responses_path, "post" do

      assert_select "input[name=?]", "invitation_response[user]"

      assert_select "input[name=?]", "invitation_response[team]"
    end
  end
end
