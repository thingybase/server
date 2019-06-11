require 'rails_helper'

RSpec.describe "users/show", type: :view do
  before(:each) do
    @user = assign(:user, User.create!(
      name: "Name",
      email: "Email",
      password_hash: "Password Hash",
      alias: "Alias",
      phone_number: "Phone Number"
    ))
  end

  xit "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Email/)
    expect(rendered).to match(/Password Hash/)
    expect(rendered).to match(/Alias/)
    expect(rendered).to match(/Phone Number/)
  end
end
