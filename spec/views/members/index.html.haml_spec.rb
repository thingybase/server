require 'rails_helper'

RSpec.describe "members/index", type: :view do
  before(:each) do
    assign(:members, [
      Member.create!(
        :user => nil,
        :team => nil
      ),
      Member.create!(
        :user => nil,
        :team => nil
      )
    ])
  end

  xit "renders a list of members" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
