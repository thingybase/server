require 'rails_helper'

RSpec.describe LoanableListMemberRequest, type: :model do
  subject { build(:loanable_list_member_request) }
  it { is_expected.to belong_to(:loanable_list).required(true) }
  it { is_expected.to belong_to(:user).required(true) }
  it { is_expected.to validate_uniqueness_of(:user_id).scoped_to(:loanable_list_id) }
end
