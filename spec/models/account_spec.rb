require 'rails_helper'

RSpec.describe Account, type: :model do
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:user) }
  it { is_expected.to belong_to(:user) }
  it { is_expected.to have_many(:users) }
  it { is_expected.to have_many(:invitations) }
  it { is_expected.to have_many(:subscriptions) }
end
