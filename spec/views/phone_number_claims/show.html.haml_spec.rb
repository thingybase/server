require 'rails_helper'

RSpec.describe "phone_number_claims/show", type: :view do
  before(:each) do
    @phone_number_claim = assign(:phone_number_claim, PhoneNumberClaim.create!(
      :phone_number => "Phone Number",
      :code => "Code",
      :user => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Phone Number/)
    expect(rendered).to match(/Code/)
    expect(rendered).to match(//)
  end
end
