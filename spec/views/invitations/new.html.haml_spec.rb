require 'rails_helper'

RSpec.describe "invitations/new", type: :view do
  before(:each) do
    assign(:invitation, Invitation.new(
      :email => "MyString",
      :name => "MyString",
      :token => "MyString",
      :team => nil,
      :user => nil
    ))
  end

  it "renders new invitation form" do
    render

    assert_select "form[action=?][method=?]", invitations_path, "post" do

      assert_select "input[name=?]", "invitation[email]"

      assert_select "input[name=?]", "invitation[name]"

      assert_select "input[name=?]", "invitation[token]"

      assert_select "input[name=?]", "invitation[team_id]"

      assert_select "input[name=?]", "invitation[user_id]"
    end
  end
end
