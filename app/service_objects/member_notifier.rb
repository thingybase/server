class MemberNotifier
  FROM_PHONE_NUMBER = '+13372843122'.freeze

  def initialize(phone_number)
    @phone_number = phone_number
  end

  # Sends SMS to user.
  def notify
    send_sms
  end

  # TODO: Move this into a dang service object
  def sms_message(message)
    twilio = Twilio::REST::Client.new
    twilio.api.account.messages.create(
      from: FROM_PHONE_NUMBER,
      to: @phone_number,
      body: message)
  end
end
