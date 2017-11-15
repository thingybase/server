require 'rails_helper'

RSpec.describe Notification, type: :model do
  it { is_expected.to validate_presence_of(:subject) }
  it { is_expected.to validate_presence_of(:user) }
  it { is_expected.to validate_presence_of(:team) }
  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:team) }
  it { is_expected.to has_one(:acknowledgement) }

  describe ".deliver"
end
