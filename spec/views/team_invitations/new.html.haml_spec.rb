require 'rails_helper'

RSpec.describe "team_invitations/new", type: :view do
  before(:each) do
    assign(:team_invitation, TeamInvitation.new(
      :email => "MyString",
      :name => "MyString",
      :token => "MyString",
      :team => nil,
      :user => nil
    ))
  end

  it "renders new team_invitation form" do
    render

    assert_select "form[action=?][method=?]", team_invitations_path, "post" do

      assert_select "input[name=?]", "team_invitation[email]"

      assert_select "input[name=?]", "team_invitation[name]"

      assert_select "input[name=?]", "team_invitation[token]"

      assert_select "input[name=?]", "team_invitation[team_id]"

      assert_select "input[name=?]", "team_invitation[user_id]"
    end
  end
end
