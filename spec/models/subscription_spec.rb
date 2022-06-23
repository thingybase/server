require 'rails_helper'

RSpec.describe Subscription, type: :model do
  subject { build(:subscription) }
  it { is_expected.to belong_to(:user).required(true) }
  it { is_expected.to belong_to(:account).required(true) }
  it { is_expected.to validate_presence_of(:expires_at) }
  it { is_expected.to validate_presence_of(:plan) }
end
