require 'rails_helper'

RSpec.describe "members/edit", type: :view do
  before(:each) do
    @member = assign(:member, Member.create!(
      user: nil,
      account: nil
    ))
  end

  xit "renders the edit member form" do
    render

    assert_select "form[action=?][method=?]", member_path(@member), "post" do

      assert_select "input[name=?]", "member[user_id]"

      assert_select "input[name=?]", "member[account_id]"
    end
  end
end
