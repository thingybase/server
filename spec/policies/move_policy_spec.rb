require 'rails_helper'

describe MovePolicy do
  subject { described_class.new(user, record) }
  let(:record) { create(:move) }
  let(:account) { record.account }

  context 'visitor' do
    let(:user) { nil }
    it { is_expected.to forbid_action(:show) }
    it { is_expected.to forbid_action(:edit) }
    it { is_expected.to forbid_action(:update) }
    it { is_expected.to forbid_action(:create) }
    it { is_expected.to forbid_action(:new) }
    it { is_expected.to forbid_action(:destroy) }
    it { is_expected.to forbid_action(:index) }
  end

  context 'account owner' do
    let(:user) { account.user }
    it { is_expected.to permit_action(:show) }
    it { is_expected.to permit_action(:edit) }
    it { is_expected.to permit_action(:update) }
    it { is_expected.to permit_action(:create) }
    it { is_expected.to permit_action(:new) }
    it { is_expected.to permit_action(:destroy) }
    it { is_expected.to permit_action(:index) }
  end

  context 'record owner' do
    let(:user) { account.add_user record.user }
    it { is_expected.to forbid_action(:edit) }
    it { is_expected.to forbid_action(:update) }
    it { is_expected.to forbid_action(:create) }
    it { is_expected.to forbid_action(:new) }
    it { is_expected.to forbid_action(:destroy) }
    it { is_expected.to permit_action(:show) }
    it { is_expected.to permit_action(:index) }
  end

  context 'member' do
    let(:user) { account.add_user create(:user) }
    it { is_expected.to forbid_action(:edit) }
    it { is_expected.to forbid_action(:update) }
    it { is_expected.to forbid_action(:create) }
    it { is_expected.to forbid_action(:destroy) }
    it { is_expected.to forbid_action(:new) }
    it { is_expected.to permit_action(:show) }
    it { is_expected.to permit_action(:index) }
  end

  context 'non-member' do
    let(:user) { create(:user) }
    it { is_expected.to forbid_action(:show) }
    it { is_expected.to forbid_action(:edit) }
    it { is_expected.to forbid_action(:update) }
    it { is_expected.to forbid_action(:destroy) }
    it { is_expected.to forbid_action(:create) }
    it { is_expected.to forbid_action(:index) }
    it { is_expected.to forbid_action(:new) }
  end
end
