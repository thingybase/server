require 'rails_helper'

RSpec.describe "acknowledgements/new", type: :view do
  before(:each) do
    assign(:acknowledgement, Acknowledgement.new(
      :user => nil,
      :notification => nil
    ))
  end

  it "renders new acknowledgement form" do
    render

    assert_select "form[action=?][method=?]", acknowledgements_path, "post" do

      assert_select "input[name=?]", "acknowledgement[user_id]"

      assert_select "input[name=?]", "acknowledgement[notification_id]"
    end
  end
end
