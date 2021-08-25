require 'rails_helper'

RSpec.describe Member, type: :model do
  subject { build(:member) }
  it { is_expected.to belong_to(:account).required(true) }
  it { is_expected.to belong_to(:user).required(true) }
  it { is_expected.to validate_uniqueness_of(:user_id).scoped_to(:account_id) }
end
