require 'rails_helper'

RSpec.describe InvitationResponse, type: :model do
  it { is_expected.to validate_presence_of(:user) }
  it { is_expected.to validate_presence_of(:invitation) }
  describe "#status" do
    it { is_expected.to validate_presence_of(:status) }
    it { is_expected.to allow_value("accept").for(:status) }
    it { is_expected.to allow_value("decline").for(:status) }
    it { is_expected.to_not allow_value("garbage").for(:status) }
  end
  describe "#save" do
    let(:invitation) { create(:invitation) }
    let(:user) { create(:user) }
    subject { InvitationResponse.new(user: user, invitation: invitation, status: status) }
    before { subject }
    context "accept" do
      let(:status) { "accept" }
      it "destroys invitation" do
        expect{subject.save}.to change{Invitation.count}.by(-1)
      end
      it "creates member on team" do
        expect{subject.save}.to change{invitation.team.members.where(user: user).count}.by(1)
      end
    end
    context "decline" do
      let(:status) { "decline" }
      it "destroys invitation" do
        expect{subject.save}.to change{Invitation.count}.by(-1)
      end
    end
  end
end
