require 'rails_helper'

describe UserPolicy do
  subject { described_class.new(user, record) }
  let(:record) { create(:user) }

  context 'themselves' do
    let(:user) { record }
    it { is_expected.to permit_action(:show) }
    it { is_expected.to permit_action(:update) }
    it { is_expected.to permit_action(:destroy) }
  end

  context 'another user' do
    let(:user) { create(:user) }
    it { is_expected.to forbid_action(:show) }
    it { is_expected.to forbid_action(:update) }
    it { is_expected.to forbid_action(:destroy) }
  end

  context 'visitor' do
    let(:user) { nil }
    it { is_expected.to forbid_action(:show) }
    it { is_expected.to forbid_action(:update) }
  end
end
