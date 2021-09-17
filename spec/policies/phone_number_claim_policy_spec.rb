# require 'rails_helper'

# describe PhoneNumberClaimPolicy do
#   subject { described_class.new(user, record) }
#   let(:record) { create(:phone_number_claim) }

#   context 'a visitor' do
#     let(:user) { nil }
#     it { is_expected.to forbid_action(:show) }
#     it { is_expected.to forbid_action(:edit) }
#     it { is_expected.to forbid_action(:update) }
#     it { is_expected.to forbid_action(:create) }
#     it { is_expected.to forbid_action(:new) }
#     it { is_expected.to forbid_action(:destroy) }
#     it { is_expected.to forbid_action(:index) }
#   end

#   context 'an owner' do
#     let(:user) { record.user }
#     it { is_expected.to forbid_action(:edit) }
#     it { is_expected.to forbid_action(:update) }

#     it { is_expected.to permit_action(:show) }
#     it { is_expected.to permit_action(:create) }
#     it { is_expected.to permit_action(:new) }
#     it { is_expected.to permit_action(:destroy) }
#     it { is_expected.to permit_action(:index) }
#   end

#   context 'not owner' do
#     let(:user) { User.create }
#     it { is_expected.to forbid_action(:show) }
#     it { is_expected.to forbid_action(:edit) }
#     it { is_expected.to forbid_action(:update) }
#     it { is_expected.to forbid_action(:destroy) }

#     it { is_expected.to permit_action(:create) }
#     it { is_expected.to permit_action(:new) }
#     it { is_expected.to permit_action(:index) }
#   end
# end
