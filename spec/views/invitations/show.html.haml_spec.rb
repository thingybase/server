require 'rails_helper'

RSpec.describe "invitations/show", type: :view do
  before(:each) do
    @invitation = assign(:invitation, Invitation.create!(
      :email => "Email",
      :name => "Name",
      :token => "Token",
      :team => nil,
      :user => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Email/)
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Token/)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
