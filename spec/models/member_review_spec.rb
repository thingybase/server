require 'rails_helper'

RSpec.describe MemberReview, type: :model do
  subject { MemberReview.new(member_request: build(:member_request)) }
  describe "#status" do
    it { is_expected.to validate_presence_of(:status) }
    it { is_expected.to allow_value("accept").for(:status) }
    it { is_expected.to allow_value("decline").for(:status) }
    it { is_expected.to_not allow_value("garbage").for(:status) }
  end
  describe "#save" do
    let(:member_request) { create(:member_request) }
    let(:user) { member_request.user }
    let(:account) { member_request.account }
    subject { MemberReview.new(member_request: member_request, status: status) }
    before { subject }
    context "accept" do
      let(:status) { "accept" }
      it "destroys member_request" do
        expect{subject.save}.to change{MemberRequest.count}.by(-1)
      end
      it "creates member on account" do
        expect{subject.save}.to change{member_request.account.members.where(user: user).count}.by(1)
      end
    end
    context "decline" do
      let(:status) { "decline" }
      it "destroys member_request" do
        expect{subject.save}.to change{MemberRequest.count}.by(-1)
      end
    end
  end
end
