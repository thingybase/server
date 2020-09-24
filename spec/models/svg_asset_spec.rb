require 'rails_helper'

RSpec.describe SvgAsset, type: :model do
  it { is_expected.to validate_presence_of(:path) }
  describe ".find!" do
    context "file exists" do
      it "returns SvgAsset instance" do
        expect(SvgAsset.find!("folder")).to be_a SvgAsset
      end
    end
    context "file does not exist" do
      it "raises ActiveRecord::RecordNotFound" do
        expect{SvgAsset.find!("non-existant-jibber-jabber")}.to raise_error(SvgAsset::IconNotFound)
      end
    end
  end
  describe "#fingerprint" do
    subject { build(:svg_icon_file, key: "folder") }
    it "is md5 digest of file" do
      expect(subject.fingerprint).to eql("bc9559ead2b59fa0133d97a81c2e42af")
    end
  end
end
