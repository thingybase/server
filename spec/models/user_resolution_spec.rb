require 'rails_helper'

RSpec.describe UserResolution, type: :model do
  subject { build(:user_resolution) }
  it { is_expected.to validate_presence_of(:email) }
  describe "#email" do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to allow_value("dog@cat.com").for(:email) }
    it { is_expected.not_to allow_value("dog").for(:email) }
  end
end
