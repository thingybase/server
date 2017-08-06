require 'rails_helper'

RSpec.describe Notification, type: :model do
  it "creates valid user" do
    expect(build(:notification)).to be_valid
  end
end
