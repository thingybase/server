require 'rails_helper'

RSpec.describe LoanableList, type: :model do
  subject { create(:loanable_list) }
  describe "account" do
    it { is_expected.to validate_uniqueness_of(:account) }
    it { is_expected.to belong_to(:account).required(true) }
  end
  it { is_expected.to belong_to(:user).required(true) }
  it { is_expected.to validate_presence_of(:name) }
end
