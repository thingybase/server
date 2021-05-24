require 'rails_helper'

RSpec.describe Movement, type: :model do
  subject { build(:movement) }
  it { is_expected.to validate_presence_of(:user) }
  it { is_expected.to validate_presence_of(:move) }
  it { is_expected.to validate_presence_of(:destination) }
  describe "origin" do
    it { is_expected.to validate_presence_of(:origin) }
    it { is_expected.to validate_uniqueness_of(:origin).scope_to(:move_id) }
  end
end
