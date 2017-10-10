require 'rails_helper'

describe AcknowledgementPolicy do
  subject { described_class.new(user, acknowledgement) }

  let(:acknowledgement) { create(:acknowledgement) }

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

  context 'a team owner' do
    let(:user) { acknowledgement.notification.team.user }
    it { is_expected.to permit_action(:show) }
    it { is_expected.to permit_action(:edit) }
    it { is_expected.to permit_action(:update) }
    it { is_expected.to permit_action(:create) }
    it { is_expected.to permit_action(:new) }
    it { is_expected.to permit_action(:destroy) }
    it { is_expected.to permit_action(:index) }
  end

  context 'a member to themselves' do
    let(:user) { acknowledgement.user }
    before { create(:member, user: user, team: acknowledgement.notification.team)}
    it { is_expected.to permit_action(:edit) }
    it { is_expected.to permit_action(:update) }
    it { is_expected.to permit_action(:destroy) }
    it { is_expected.to permit_action(:create) }
    it { is_expected.to permit_action(:new) }
    it { is_expected.to permit_action(:show) }
    it { is_expected.to permit_action(:index) }
  end

  context 'a member to another member' do
    let(:user) { create(:member, team: acknowledgement.notification.team).user }
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
