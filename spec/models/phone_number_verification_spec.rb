require 'rails_helper'

RSpec.describe PhoneNumberVerification, type: :model do
  subject { claim.verification(code: claim.code) }
  let(:claim){ create(:phone_number_claim) }

  it { is_expected.to validate_presence_of(:claim) }
  describe "#code" do
    it { is_expected.to validate_presence_of(:code) }
    it { is_expected.to allow_value(claim.code).for(:code) }
    it { is_expected.not_to allow_value("22").for(:code) }
  end
  describe "#save" do
    it "destroys claim" do
      expect(claim).to receive(:destroy).once
      subject.save
    end
    it "sets user phone number" do
      subject.save
      expect(claim.user.phone_number).to eql(claim.phone_number)
    end
    context "claim another users phone_number" do
      let(:defendant) { create(:user, phone_number: claim.phone_number) }
      let(:claimant) { claim.user }
      it "nullifies other user's phone_number" do
        expect(defendant.phone_number).to_not be_nil
        expect(defendant.phone_number).to eql(claim.phone_number)
        subject.save
        expect(defendant.reload.phone_number).to be_nil
      end
    end
  end
end
