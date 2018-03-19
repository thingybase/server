require 'rails_helper'

RSpec.describe ApiToken, type: :model do
  subject { build(:api_token) }
  it { is_expected.to validate_presence_of(:user) }
  describe "#access_key" do
    it { is_expected.to validate_presence_of(:access_key) }
    it { is_expected.to_not allow_value("dddddddddd").for(:access_key) }
  end
  describe "#access_id" do
    it { is_expected.to validate_uniqueness_of(:access_id) }
    it { is_expected.to validate_presence_of(:access_id) }
    it { is_expected.to_not allow_value("dddddddddd").for(:access_id) }
  end
  describe "#encode_token" do
    let(:json) { JSON.parse Base64.decode64 subject.encode_token }
    it "has access_id" do
      expect(json['access_id']).to eql(subject.access_id)
    end
    it "has access_key" do
      expect(json['access_key']).to eql(subject.access_key)
    end
  end
  describe ".find_and_authenticate" do
    subject { ApiToken.find_and_authenticate(encoded_token) }
    let(:persisted_token) { create(:api_token) }
    let(:encoded_token) { Base64.encode64 JSON.generate(access_id: access_id, access_key: access_key) }
    let(:access_key) { persisted_token.access_key }
    let(:access_id) { persisted_token.access_id }
    it "finds token" do
      expect(subject).to_not be_nil
    end
    context "invalid access_key" do
      let(:access_key) { "trash access_key" }
      it "is not found" do
        expect(subject).to be_nil
      end
    end
    context "invalid access_id" do
      let(:access_id) { "trash access_id" }
      it "is not found" do
        expect(subject).to be_nil
      end
    end
  end
end
