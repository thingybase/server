require 'rails_helper'

RSpec.describe "phone_number_verifications/show", type: :view do
  before(:each) do
    @phone_number_verification = assign(:phone_number_verification, PhoneNumberVerification.create!(
      :code => "Code"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Code/)
  end
end
