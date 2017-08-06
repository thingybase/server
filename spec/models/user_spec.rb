require 'rails_helper'

RSpec.describe User, type: :model do
  it "creates valid user" do
    expect(build(:user)).to be_valid
  end
end
