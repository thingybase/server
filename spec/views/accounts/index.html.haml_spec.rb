require 'rails_helper'

RSpec.describe "accounts/index", type: :view do
  before(:each) do
    assign(:accounts, [
      Account.create!(
        name: "Name",
        user: nil
      ),
      Account.create!(
        name: "Name",
        user: nil
      )
    ])
  end

  xit "renders a list of accounts" do
    render
    assert_select "tr>td", text: "Name".to_s, count: 2
    assert_select "tr>td", text: nil.to_s, count: 2
  end
end
