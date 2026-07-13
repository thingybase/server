require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  describe "welcome" do
    let(:user) { create(:user) }
    let(:mail) { UserMailer.welcome(user) }

    it "renders the subject" do
      expect(mail.subject).to eq("Welcome")
    end

    it "is sent to the user" do
      expect(mail.to).to eq([user.email])
    end

    it "is sent from Thingybase" do
      expect(mail.from).to eq(["website@thingybase.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Welcome to Thingybase")
    end
  end
end
