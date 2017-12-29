require 'rails_helper'

RSpec.describe "invitation_responses/index", type: :view do
  before(:each) do
    assign(:invitation_responses, [
      InvitationResponse.create!(
        :user => "",
        :team => ""
      ),
      InvitationResponse.create!(
        :user => "",
        :team => ""
      )
    ])
  end

  it "renders a list of invitation_responses" do
    render
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
  end
end
