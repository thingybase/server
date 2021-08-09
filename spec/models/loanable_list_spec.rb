require 'rails_helper'

RSpec.describe LoanableList, type: :model do
  subject { build(:loanable_list) }
  describe "account" do
    it { is_expected.to validate_presence_of(:account) }
    it { is_expected.to validate_uniqueness_of(:account) }
  end
  it { is_expected.to validate_presence_of(:user) }
  it { is_expected.to validate_presence_of(:name) }
end
