require 'rails_helper'

RSpec.describe "invitations/index", type: :view do
  before(:each) do
    assign(:invitations, [
      Invitation.create!(
        :email => "Email",
        :name => "Name",
        :token => "Token",
        :account => nil,
        :user => nil
      ),
      Invitation.create!(
        :email => "Email",
        :name => "Name",
        :token => "Token",
        :account => nil,
        :user => nil
      )
    ])
  end

  it "renders a list of invitations" do
    render
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Token".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
