require 'rails_helper'

RSpec.describe "members/new", type: :view do
  before(:each) do
    assign(:member, Member.new(
      :user => nil,
      :account => nil
    ))
  end

  xit "renders new member form" do
    render

    assert_select "form[action=?][method=?]", members_path, "post" do

      assert_select "input[name=?]", "member[user_id]"

      assert_select "input[name=?]", "member[account_id]"
    end
  end
end
