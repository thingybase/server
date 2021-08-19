require 'rails_helper'

RSpec.describe LoanableItem, type: :model do
  subject { build(:loanable_item) }
  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:account) }
  it { is_expected.to belong_to(:loanable_list) }
  describe "item" do
    it { is_expected.to belong_to(:item) }
    it { is_expected.to validate_uniqueness_of(:item).scoped_to(:loanable_list_id) }
  end
end
