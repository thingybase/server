require 'rails_helper'

RSpec.describe "acknowledgements/show", type: :view do
  before(:each) do
    @acknowledgement = assign(:acknowledgement, Acknowledgement.create!(
      :user => nil,
      :notification => nil
    ))
  end

  xit "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
