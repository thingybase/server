require 'rails_helper'

RSpec.describe "phone_number_claims/index", type: :view do
  before(:each) do
    assign(:phone_number_claims, [
      PhoneNumberClaim.create!(
        :phone_number => "Phone Number",
        :code => "Code",
        :user => nil
      ),
      PhoneNumberClaim.create!(
        :phone_number => "Phone Number",
        :code => "Code",
        :user => nil
      )
    ])
  end

  it "renders a list of phone_number_claims" do
    render
    assert_select "tr>td", :text => "Phone Number".to_s, :count => 2
    assert_select "tr>td", :text => "Code".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
