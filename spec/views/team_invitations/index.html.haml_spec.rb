require 'rails_helper'

RSpec.describe "team_invitations/index", type: :view do
  before(:each) do
    assign(:team_invitations, [
      TeamInvitation.create!(
        :email => "Email",
        :name => "Name",
        :token => "Token",
        :team => nil,
        :user => nil
      ),
      TeamInvitation.create!(
        :email => "Email",
        :name => "Name",
        :token => "Token",
        :team => nil,
        :user => nil
      )
    ])
  end

  it "renders a list of team_invitations" do
    render
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Token".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
