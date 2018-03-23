require "uri"

class MemberNotifier
  FROM_PHONE_NUMBER = '+13372843122'.freeze

  def initialize(phone_number)
    @phone_number = phone_number
  end

  # Sends SMS and voice call to user.
  def notify
    send_sms
    voice_call
  end

  # TODO: Move this into a dang service object
  def sms_message(message)
    twilio = Twilio::REST::Client.new
    twilio.api.account.messages.create(
      from: FROM_PHONE_NUMBER,
      to: @phone_number,
      body: message)
  end

  def voice_call(message, acknowledgement_url: )
    twilio = Twilio::REST::Client.new
    twilio.api.account.calls.create(
      from: FROM_PHONE_NUMBER,
      to: @phone_number,
      # url: 'http://demo.twilio.com/docs/voice.xml'
      # TODO: Refactor this so its not a TwiMLet.
      url: voice_menu_url("#{message}. Press 0 to acknowledge, press 1 to pass", [
        acknowledgement_url,
        voice_message_url("Lame, you can't fix it.")
      ])
    )
  end

  private
    def voice_menu_url(message, options = [])
      URI("http://twimlets.com/menu").tap do |url|
        url.query = {"Message" => message, "Options" => options}.to_query
      end
    end

    def voice_message_url(message)
      URI("http://twimlets.com/message").tap do |url|
        url.query = {"Message" => [message]}.to_query
      end
    end
end