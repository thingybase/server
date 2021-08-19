require 'rails_helper'

RSpec.describe Movement, type: :model do
  subject { build(:movement) }
  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:move) }
  it { is_expected.to belong_to(:account) }
  describe "origin" do
    it { is_expected.to validate_presence_of(:origin) }
    it { is_expected.to validate_uniqueness_of(:origin).scoped_to(:move_id) }
  end
  describe "destination" do
    it { is_expected.to validate_presence_of(:destination) }
    it "must be a container"
  end
end
