require 'rails_helper'

describe InvitationResponsePolicy do
  subject { described_class.new(user, invitation.response) }
  let(:invitation) { create(:invitation) }

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

  context 'an owner' do
    let(:user) { invitation.account.user }
    it { is_expected.to forbid_action(:show) }
    it { is_expected.to forbid_action(:create) }
    it { is_expected.to forbid_action(:new) }
    it { is_expected.to forbid_action(:destroy) }
    it { is_expected.to forbid_action(:index) }

    it { is_expected.to permit_action(:edit) }
    it { is_expected.to permit_action(:update) }
  end

  context 'a member' do
    let(:user) { create(:member, account: invitation.account).user }
    it { is_expected.to forbid_action(:show) }
    it { is_expected.to forbid_action(:create) }
    it { is_expected.to forbid_action(:new) }
    it { is_expected.to forbid_action(:destroy) }
    it { is_expected.to forbid_action(:index) }

    it { is_expected.to permit_action(:edit) }
    it { is_expected.to permit_action(:update) }
  end

  context 'not a member' do
    let(:user) { User.create }
    it { is_expected.to forbid_action(:show) }
    it { is_expected.to forbid_action(:create) }
    it { is_expected.to forbid_action(:new) }
    it { is_expected.to forbid_action(:destroy) }
    it { is_expected.to forbid_action(:index) }

    it { is_expected.to permit_action(:edit) }
    it { is_expected.to permit_action(:update) }
  end
end
