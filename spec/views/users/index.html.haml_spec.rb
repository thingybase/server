require 'rails_helper'

RSpec.describe "users/index", type: :view do
  before(:each) do
    assign(:users, [
      User.create!(
        :name => "Name",
        :email => "Email",
        :password_hash => "Password Hash",
        :alias => "Alias",
        :phone_number => "Phone Number"
      ),
      User.create!(
        :name => "Name",
        :email => "Email",
        :password_hash => "Password Hash",
        :alias => "Alias",
        :phone_number => "Phone Number"
      )
    ])
  end

  it "renders a list of users" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    assert_select "tr>td", :text => "Password Hash".to_s, :count => 2
    assert_select "tr>td", :text => "Alias".to_s, :count => 2
    assert_select "tr>td", :text => "Phone Number".to_s, :count => 2
  end
end
