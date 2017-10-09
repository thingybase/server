require 'rails_helper'

RSpec.describe "notifications/edit", type: :view do
  before(:each) do
    @notification = assign(:notification, Notification.create!(
      :subject => "MyString",
      :message => "MyString",
      :user => nil
    ))
  end

  xit "renders the edit notification form" do
    render

    assert_select "form[action=?][method=?]", notification_path(@notification), "post" do

      assert_select "input[name=?]", "notification[subject]"

      assert_select "input[name=?]", "notification[message]"

      assert_select "input[name=?]", "notification[user_id]"
    end
  end
end
