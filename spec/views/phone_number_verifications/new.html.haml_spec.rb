require 'rails_helper'

RSpec.describe "phone_number_verifications/new", type: :view do
  before(:each) do
    assign(:phone_number_verification, PhoneNumberVerification.new(
      code: "MyString"
    ))
  end

  it "renders new phone_number_verification form" do
    render

    assert_select "form[action=?][method=?]", phone_number_verifications_path, "post" do

      assert_select "input[name=?]", "phone_number_verification[code]"
    end
  end
end
