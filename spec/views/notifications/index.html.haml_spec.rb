require 'rails_helper'

RSpec.describe "notifications/index", type: :view do
  before(:each) do
    assign(:notifications, [
      Notification.create!(
        :subject => "Subject",
        :message => "Message",
        :user => nil
      ),
      Notification.create!(
        :subject => "Subject",
        :message => "Message",
        :user => nil
      )
    ])
  end

  it "renders a list of notifications" do
    render
    assert_select "tr>td", :text => "Subject".to_s, :count => 2
    assert_select "tr>td", :text => "Message".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
