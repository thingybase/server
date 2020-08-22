require 'rails_helper'

RSpec.describe MemberRequest, type: :model do
  subject { build(:member_request) }
  describe "#user" do
    it { is_expected.to validate_presence_of(:user) }
    it { is_expected.to validate_uniqueness_of(:user_id).scoped_to(:account_id) }
  end
  it { is_expected.to validate_presence_of(:account) }
end
