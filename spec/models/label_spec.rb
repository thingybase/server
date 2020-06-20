require 'rails_helper'

RSpec.describe Label, type: :model do
  subject { build(:label) }
  it { is_expected.to validate_presence_of(:text) }
  # it { is_expected.to validate_presence_of(:uuid) }
end
