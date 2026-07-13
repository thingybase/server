require 'rails_helper'

describe LabelPolicy do
  subject { described_class.new(user, record) }
  let(:item) { create(:item) }
  let(:record) { item.label }
  let(:account) { item.account }

  context 'any signed-in user' do
    let(:user) { create(:user) }
    it { is_expected.to permit_action(:scan) }
    it { is_expected.to forbid_action(:show) }
    it { is_expected.to forbid_action(:update) }
    it { is_expected.to forbid_action(:destroy) }
  end

  context 'account owner' do
    let(:user) { account.user }
    it { is_expected.to permit_action(:scan) }
    it { is_expected.to permit_action(:show) }
  end
end
