require 'rails_helper'

RSpec.describe ApiKey, type: :model do
  subject { build(:api_key) }
  it { is_expected.to validate_presence_of(:user) }
  it { is_expected.to validate_presence_of(:name) }
  describe "#secret" do
    # TODO: Figure out how to make this test work while also
    # applying default values.
    # it { is_expected.to validate_presence_of(:secret) }
    it { is_expected.to_not allow_value("dddddddddd").for(:secret) }
  end
  describe "#token" do
    it "generates" do
      expect(subject.token).to_not be_blank
    end
  end
  describe "#authentic?" do
    context "valid token" do
      it "returns true" do
        expect(subject.authentic?(subject.secret)).to be true
      end
    end
    context "invalid token" do
      it "returns false" do
        expect(subject.authentic?("garbage")).to be false
      end
    end
  end
  describe ".find_and_authenticate" do
    subject { create(:api_key) }
    context "valid token" do
      it "returns instance" do
        expect(ApiKey.find_and_authenticate(subject.token)).to eql(subject)
      end
    end
    context "invalid token" do
      it "returns nil" do
        expect(ApiKey.find_and_authenticate("trash")).to be_nil
      end
    end
  end
end
