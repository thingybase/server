require 'rails_helper'

RSpec.describe "phone_number_verifications/edit", type: :view do
  before(:each) do
    @phone_number_verification = assign(:phone_number_verification, PhoneNumberVerification.create!(
      code: "MyString"
    ))
  end

  it "renders the edit phone_number_verification form" do
    render

    assert_select "form[action=?][method=?]", phone_number_verification_path(@phone_number_verification), "post" do

      assert_select "input[name=?]", "phone_number_verification[code]"
    end
  end
end
