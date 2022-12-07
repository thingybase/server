require 'rails_helper'

RSpec.describe Item, type: :model do
  subject { build(:item) }
  it { is_expected.to validate_presence_of(:name) }

  describe "#icon_key" do
    it { is_expected.to allow_value(nil).for(:icon_key) }
    it { is_expected.to allow_value("folder").for(:icon_key) }
    it { is_expected.to_not allow_value("no-asdlkjasdlkj_exists").for(:icon_key) }
  end

  describe "#icon" do
    context "container=false" do
      it "defaults to 'object'" do
        expect(subject.icon).to eql "object"
      end
    end
    context "container=true" do
      subject { build(:item, container: true) }
      it "defaults to 'folder'" do
        expect(subject.icon).to eql "folder"
      end
    end
    context "icon_key='home'" do
      subject { build(:item, icon_key: "home") }
      it "is 'folder'" do
        expect(subject.icon).to eql "home"
      end
    end
  end

  describe "#container" do
    context "true" do
      subject { build(:item, container: true) }
      it "#children#<< does not raise error" do
        expect{subject.children << build(:item)}.to_not raise_error
      end
      it "#add_child does not raise error" do
        expect{subject.add_child build(:item)}.to_not raise_error
      end
      context "changing to false" do
        subject { build(:item, container: true) }
        context "with children" do
          before do
            subject.children << build(:item)
            subject.container = false
          end
          it { is_expected.to_not be_valid }
        end
        context "without children" do
          before do
            subject.container = false
          end
          it { is_expected.to be_valid }
        end
      end
    end
    context "false" do
      subject { build(:item, container: false) }
      it "#children#<< raises error" do
        expect{subject.children << build(:item)}.to raise_error(Item::ReadonlyAssociationDelegate::AppendError)
      end
      it "#add_child raises error" do
        expect{subject.add_child build(:item)}.to raise_error(Item::ReadonlyAssociationDelegate::AppendError)
      end
    end
  end

  describe "#parent" do
    let(:root) { build(:item) }
    context "root" do
      subject { root }
      it { is_expected.to be_root }
      it { is_expected.to be_valid }
    end
    describe "validate parent" do
      let(:root) { build(:item, container: parent_is_container) }
      let(:child) { build(:item, parent: root)  }
      subject { child }
      context "is container" do
        let(:parent_is_container) { true }
        it { is_expected.to_not be_root }
        it { is_expected.to be_valid }
      end
      context "is not container" do
        let(:parent_is_container) { false }
        it { is_expected.to_not be_root }
        it { is_expected.to_not be_valid }
      end
    end
  end

  describe "#search_by_name" do
    let!(:hood) { create(:item, name: "Hood - 48-58mm") }
    let!(:nikon) { create(:item, name: "Nikon HB-35 lens hood") }
    let!(:ew) { create(:item, name: "EW-63C lens hood") }
    let!(:hook) { create(:item, name: "Ook Hooks") }
    let(:results) { Item.search_by_name(term) }
    subject { results }

    context "hoo" do
      let(:term) { "hoo" }
      it { is_expected.to include(hood, nikon, ew, hook) }
    end

    context "hook" do
      let(:term) { "hook" }
      it { is_expected.to include(hook) }
      it { is_expected.to_not include(hood, nikon, ew) }
    end

    context "hood" do
      let(:term) { "hood" }
      it { is_expected.to include(hood, nikon, ew) }
      it { is_expected.to_not include(hook) }
    end

    context "hoods" do
      let(:term) { "hoods" }
      it { is_expected.to be_empty }
      it { is_expected.to_not include(hood, nikon, ew, hook) }
    end
  end
end
