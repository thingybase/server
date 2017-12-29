require 'rails_helper'

RSpec.describe Invitation, type: :model do
  subject { build(:invitation) }
  it { is_expected.to belong_to(:team) }
  it { is_expected.to belong_to(:user) }
  it { is_expected.to validate_presence_of(:team) }
  it { is_expected.to validate_presence_of(:user) }
  it { is_expected.to validate_presence_of(:email) }
  describe "#token" do
    it { is_expected.to_not allow_value("weaksauce").for(:token) }
    it { is_expected.to allow_value("81303c0228734ce72689724ddfd78310").for(:token) }
    it { is_expected.to validate_uniqueness_of(:token) }
    it "sets token on save if nil" do
      expect(subject.tap(&:save).token.length).to eql(32)
    end
  end
end
