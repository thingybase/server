require 'rails_helper'

RSpec.describe User, type: :model do
  subject { build(:user) }
  it { is_expected.to validate_presence_of(:name) }
  describe "#email" do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to allow_value("dog@cat.com").for(:email) }
    it { is_expected.not_to allow_value("dog").for(:email) }
  end

  describe ".find_or_create_from_auth_hash" do
    context "existing user"
    context "new user"
  end
end
