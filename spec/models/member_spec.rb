require 'rails_helper'

RSpec.describe Member, type: :model do
  it { is_expected.to validate_presence_of(:team) }
  it { is_expected.to validate_presence_of(:user) }
  it { is_expected.to validate_uniqueness_of(:user_id).scoped_to(:team_id) }
  it { is_expected.to belong_to(:team) }
  it { is_expected.to belong_to(:user) }
end
