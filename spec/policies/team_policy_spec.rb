require 'rails_helper'

describe TeamPolicy do
  subject { described_class.new(user, team) }

  let(:team) { Team.create }

  context 'being a visitor' do
    let(:user) { nil }
    it { is_expected.to forbid_actions([:show, :edit, :create, :new, :destroy, :index]) }
  end

  context 'being an owner' do
    let(:user) { User.create }
    it { is_expected.to permit_actions([:show, :edit, :create, :new, :destroy, :index]) }
  end

  context 'being a member' do
    let(:user) { User.create }
    it { is_expected.to permit_actions([:show, :index]) }
    it { is_expected.to forbid_actions([:edit, :create, :new, :destroy]) }
  end

  context 'not being a member' do
    let(:user) { User.create }
    it { is_expected.to forbid_actions([:show, :edit, :create, :new, :destroy]) }
  end
end
