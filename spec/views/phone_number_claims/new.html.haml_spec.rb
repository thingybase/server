require 'rails_helper'

RSpec.describe "phone_number_claims/new", type: :view do
  before(:each) do
    assign(:phone_number_claim, PhoneNumberClaim.new(
      :phone_number => "MyString",
      :code => "MyString",
      :user => nil
    ))
  end

  it "renders new phone_number_claim form" do
    render

    assert_select "form[action=?][method=?]", phone_number_claims_path, "post" do

      assert_select "input[name=?]", "phone_number_claim[phone_number]"

      assert_select "input[name=?]", "phone_number_claim[code]"

      assert_select "input[name=?]", "phone_number_claim[user_id]"
    end
  end
end
