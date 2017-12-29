require 'rails_helper'

RSpec.describe "invitations/edit", type: :view do
  before(:each) do
    @invitation = assign(:invitation, Invitation.create!(
      :email => "MyString",
      :name => "MyString",
      :token => "MyString",
      :team => nil,
      :user => nil
    ))
  end

  it "renders the edit invitation form" do
    render

    assert_select "form[action=?][method=?]", invitation_path(@invitation), "post" do

      assert_select "input[name=?]", "invitation[email]"

      assert_select "input[name=?]", "invitation[name]"

      assert_select "input[name=?]", "invitation[token]"

      assert_select "input[name=?]", "invitation[team_id]"

      assert_select "input[name=?]", "invitation[user_id]"
    end
  end
end
