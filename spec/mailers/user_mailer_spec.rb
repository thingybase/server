require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  describe "welcome" do
    let(:mail) { UserMailer.welcome }

    it "renders the headers" do
      user = create(:user)

      expect(mail.subject).to eq("Welcome")
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(["website@thingybase.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

end
