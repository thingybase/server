require 'rails_helper'

RSpec.describe Item, type: :model do
  subject { build(:item) }
  it { is_expected.to validate_presence_of(:name) }
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
end
