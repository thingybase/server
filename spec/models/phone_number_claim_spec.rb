require 'rails_helper'

RSpec.describe PhoneNumberClaim, type: :model do
  it { is_expected.to validate_presence_of(:user) }
  describe "#code" do
    it { is_expected.to allow_value("88888888").for(:code) }
    it { is_expected.not_to allow_value("22").for(:code) }
    it { is_expected.not_to allow_value("999999999").for(:code) }
    it "sets random code on save if nil" do
      expect(subject.tap(&:save).code.length).to eql(8)
    end
  end
  describe "#phone_number" do
    it { is_expected.to validate_presence_of(:phone_number) }
    it { is_expected.to allow_value("+15555555555").for(:phone_number) }
    it { is_expected.to allow_value("+495555555555").for(:phone_number) }
    it { is_expected.not_to allow_value("dog").for(:phone_number) }
  end
  describe ".random_code" do
    it "is 8 digits" do
      expect(described_class.random_code.length).to eql(8)
    end
  end
end
