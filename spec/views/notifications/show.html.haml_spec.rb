require 'rails_helper'

RSpec.describe "notifications/show", type: :view do
  before(:each) do
    @notification = assign(:notification, Notification.create!(
      :subject => "Subject",
      :message => "Message",
      :user => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Subject/)
    expect(rendered).to match(/Message/)
    expect(rendered).to match(//)
  end
end
