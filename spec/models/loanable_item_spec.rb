require 'rails_helper'

RSpec.describe LoanableItem, type: :model do
  subject { create(:loanable_item) }
  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:account) }
  it { is_expected.to belong_to(:loanable_list) }
  describe "item" do
    it { is_expected.to belong_to(:item) }
    it { is_expected.to validate_uniqueness_of(:item)
          .scoped_to(:loanable_list_id)
          .with_message("is already loanable") }
    context "is container" do
      let(:item) { build(:item, container: true) }
      it { is_expected.to_not allow_value(item).for(:item) }
    end
  end
end
