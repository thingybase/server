require 'rails_helper'

RSpec.describe "team_invitations/edit", type: :view do
  before(:each) do
    @team_invitation = assign(:team_invitation, TeamInvitation.create!(
      :email => "MyString",
      :name => "MyString",
      :token => "MyString",
      :team => nil,
      :user => nil
    ))
  end

  it "renders the edit team_invitation form" do
    render

    assert_select "form[action=?][method=?]", team_invitation_path(@team_invitation), "post" do

      assert_select "input[name=?]", "team_invitation[email]"

      assert_select "input[name=?]", "team_invitation[name]"

      assert_select "input[name=?]", "team_invitation[token]"

      assert_select "input[name=?]", "team_invitation[team_id]"

      assert_select "input[name=?]", "team_invitation[user_id]"
    end
  end
end
