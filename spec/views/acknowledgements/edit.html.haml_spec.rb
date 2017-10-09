require 'rails_helper'

RSpec.describe "acknowledgements/edit", type: :view do
  before(:each) do
    @acknowledgement = assign(:acknowledgement, create(:acknowledgement))
  end

  it "renders the edit acknowledgement form" do
    render

    assert_select "form[action=?][method=?]", acknowledgement_path(@acknowledgement), "post" do

      assert_select "input[name=?]", "acknowledgement[user_id]"

      assert_select "input[name=?]", "acknowledgement[notification_id]"
    end
  end
end
