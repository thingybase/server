require 'rails_helper'

RSpec.describe "phone_number_verifications/index", type: :view do
  before(:each) do
    assign(:phone_number_verifications, [
      PhoneNumberVerification.create!(
        :code => "Code"
      ),
      PhoneNumberVerification.create!(
        :code => "Code"
      )
    ])
  end

  it "renders a list of phone_number_verifications" do
    render
    assert_select "tr>td", :text => "Code".to_s, :count => 2
  end
end
