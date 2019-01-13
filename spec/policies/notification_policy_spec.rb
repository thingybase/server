require 'rails_helper'

describe NotificationPolicy do
  subject { described_class.new(user, notification) }

  let(:notification) { create(:notification) }

  context 'a visitor' do
    let(:user) { nil }
    it { is_expected.to forbid_action(:show) }
    it { is_expected.to forbid_action(:edit) }
    it { is_expected.to forbid_action(:update) }
    it { is_expected.to forbid_action(:create) }
    it { is_expected.to forbid_action(:new) }
    it { is_expected.to forbid_action(:destroy) }
    it { is_expected.to forbid_action(:index) }
  end

  context 'a account owner' do
    let(:user) { notification.account.user }
    it { is_expected.to permit_action(:show) }
    it { is_expected.to permit_action(:edit) }
    it { is_expected.to permit_action(:update) }
    it { is_expected.to permit_action(:create) }
    it { is_expected.to permit_action(:new) }
    it { is_expected.to permit_action(:destroy) }
    it { is_expected.to permit_action(:index) }
  end

  context 'a member to themselves' do
    let(:user) { notification.user }
    before { create(:member, user: notification.user, account: notification.account) }
    it { is_expected.to permit_action(:edit) }
    it { is_expected.to permit_action(:update) }
    it { is_expected.to permit_action(:destroy) }
    it { is_expected.to permit_action(:create) }
    it { is_expected.to permit_action(:new) }
    it { is_expected.to permit_action(:show) }
    it { is_expected.to permit_action(:index) }
  end

  context 'a member to another member' do
    let(:user) { create(:user) }
    before { create(:member, user: user, account: notification.account) }
    it { is_expected.to forbid_action(:edit) }
    it { is_expected.to forbid_action(:update) }
    it { is_expected.to forbid_action(:destroy) }

    it { is_expected.to permit_action(:create) }
    it { is_expected.to permit_action(:new) }
    it { is_expected.to permit_action(:show) }
    it { is_expected.to permit_action(:index) }
  end

  context 'not a member' do
    let(:user) { User.create }
    it { is_expected.to forbid_action(:show) }
    it { is_expected.to forbid_action(:edit) }
    it { is_expected.to forbid_action(:update) }
    it { is_expected.to forbid_action(:destroy) }
    it { is_expected.to forbid_action(:create) }
    it { is_expected.to forbid_action(:index) }
    it { is_expected.to permit_action(:new) }
  end
end
