require 'rails_helper'

RSpec.describe User, type: :model do
  subject { build(:email_code_verification) }
  it { is_expected.to validate_presence_of(:email) }
  before { subject.generate_random_code }
  describe "#email" do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to allow_value("dog@cat.com").for(:email) }
    it { is_expected.not_to allow_value("dog").for(:email) }
  end
  describe "#code_authenticity" do
    it { is_expected.to have_authentic_code }
    it "is not authentic" do
      subject.code = 000000
      expect(subject).to_not have_authentic_code
    end
  end
  describe "#verification_attempts" do
    describe "valid on 2nd attempt" do
      subject { build(:email_code_verification, verification_attempts: 2) }
      it { is_expected.to be_valid }
    end
    describe "invalid on 3rd attempt" do
      subject { build(:email_code_verification, verification_attempts: 3) }
      it { is_expected.to_not be_valid }
    end
  end
  describe "#has_expired?" do
    context "within time to live" do
      it { is_expected.to_not have_expired }
    end
    context "after time to live" do
      before { travel_to 6.minutes.from_now }
      it { is_expected.to have_expired }
      it { is_expected.not_to be_valid }
      after { travel_back }
    end
  end
  describe "#serializeable_session_hash" do
    it "does not serialize :code" do
      expect(subject.serializeable_session_hash.keys).to_not include :code
    end
  end
end
