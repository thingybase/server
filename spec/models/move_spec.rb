require 'rails_helper'

RSpec.describe Move, type: :model do
  subject { create(:move) }
  describe "account" do
    it { is_expected.to validate_presence_of(:account) }
    it { is_expected.to validate_uniqueness_of(:account) }
  end
  it { is_expected.to validate_presence_of(:user) }
end
