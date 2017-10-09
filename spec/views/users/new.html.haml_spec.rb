require 'rails_helper'

RSpec.describe "users/new", type: :view do
  before(:each) do
    assign(:user, User.new(
      :name => "MyString",
      :email => "MyString",
      :password_hash => "MyString",
      :alias => "MyString",
      :phone_number => "MyString"
    ))
  end

  xit "renders new user form" do
    render

    assert_select "form[action=?][method=?]", users_path, "post" do

      assert_select "input[name=?]", "user[name]"

      assert_select "input[name=?]", "user[email]"

      assert_select "input[name=?]", "user[password_hash]"

      assert_select "input[name=?]", "user[alias]"

      assert_select "input[name=?]", "user[phone_number]"
    end
  end
end
