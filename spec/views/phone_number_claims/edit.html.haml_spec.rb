require 'rails_helper'

RSpec.describe "phone_number_claims/edit", type: :view do
  before(:each) do
    @phone_number_claim = assign(:phone_number_claim, PhoneNumberClaim.create!(
      :phone_number => "MyString",
      :code => "MyString",
      :user => nil
    ))
  end

  it "renders the edit phone_number_claim form" do
    render

    assert_select "form[action=?][method=?]", phone_number_claim_path(@phone_number_claim), "post" do

      assert_select "input[name=?]", "phone_number_claim[phone_number]"

      assert_select "input[name=?]", "phone_number_claim[code]"

      assert_select "input[name=?]", "phone_number_claim[user_id]"
    end
  end
end
