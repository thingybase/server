require 'rails_helper'

RSpec.describe ItemCopy, type: :model do
  it { is_expected.to validate_presence_of(:item) }
  it { is_expected.to validate_numericality_of(:number_of_copies) }
  describe "#save" do
    let(:item) { create(:item) }
    let(:item_copier) { ItemCopy.new item: item, number_of_copies: 2 }
    before { item_copier.save }
    describe "#copies" do
      subject { item_copier.copies }
      it "has 2 items" do
        expect(subject.size).to eql 2
      end
      describe "#first" do
        subject { item_copier.copies.first }
        it "has same user" do
          expect(subject.user).to eql(item.user)
        end
        it "has same account" do
          expect(subject.account).to eql(item.account)
        end
        it "has same container" do
          expect(subject.container).to eql(item.container)
        end
      end
    end
    describe "#all" do
      subject { item_copier.all }
      it { is_expected.to include(item) }
      it "has 3 items" do
        expect(subject.size).to eql 3
      end
    end
    describe "idempotency" do
      before { item_copier.validate }
      subject { item_copier.errors.details.fetch(:item).first.fetch(:error) }
      it { is_expected.to eql "has already been copied" }
    end
  end
end
