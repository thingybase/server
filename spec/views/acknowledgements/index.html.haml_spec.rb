require 'rails_helper'

RSpec.describe "acknowledgements/index", type: :view do
  before(:each) do
    assign(:acknowledgements, [
      Acknowledgement.create!(
        :user => nil,
        :notification => nil
      ),
      Acknowledgement.create!(
        :user => nil,
        :notification => nil
      )
    ])
  end

  it "renders a list of acknowledgements" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
