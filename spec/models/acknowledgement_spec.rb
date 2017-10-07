require 'rails_helper'

RSpec.describe Acknowledgement, type: :model do
  it { is_expected.to validate_presence_of(:user) }
  it { is_expected.to validate_presence_of(:notification) }
  it { is_expected.to validate_uniqueness_of(:user_id).scoped_to(:notification_id) }
  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:notification) }
end
