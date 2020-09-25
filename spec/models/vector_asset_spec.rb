require 'rails_helper'

RSpec.describe VectorAsset, type: :model do
  it { is_expected.to validate_presence_of(:path) }
  describe ".find!" do
    context "file exists" do
      it "returns VectorAsset instance" do
        expect(VectorAsset.find!("icons/folder.svg")).to be_a VectorAsset
      end
    end
    context "file does not exist" do
      it "raises ActiveRecord::RecordNotFound" do
        expect{VectorAsset.find!("non-existant-jibber-jabber")}.to raise_error(VectorAsset::AssetNotFound)
      end
    end
  end
  describe "#fingerprint" do
    subject { build(:vector_asset, key: "icons/folder.svg") }
    it "is md5 digest of file" do
      expect(subject.fingerprint).to eql("bc9559ead2b59fa0133d97a81c2e42af")
    end
  end
end
