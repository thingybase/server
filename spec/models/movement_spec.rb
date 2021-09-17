require 'rails_helper'

RSpec.describe Movement, type: :model do
  subject { build(:movement) }
  it { is_expected.to belong_to(:user).required(true) }
  it { is_expected.to belong_to(:move).required(true) }
  it { is_expected.to belong_to(:account).required(true) }
  describe "origin" do
    it { is_expected.to belong_to(:origin).required(true) }
    it { is_expected.to validate_uniqueness_of(:origin)
          .scoped_to(:move_id)
          .with_message("has already been packed") }
  end
  describe "destination" do
    it { is_expected.to belong_to(:destination).required(true) }
    context "does not allow item" do
      let(:item) { build(:item, container: false) }
      it { is_expected.to_not allow_value(item).for(:destination) }
    end
    context "allows container" do
      let(:container) { build(:item, container: true) }
      it { is_expected.to allow_value(container).for(:destination) }
    end
  end
end
