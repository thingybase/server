class Notification < ApplicationRecord
  belongs_to :user
  validates :subject, presence: true
  validates :message, presence: true

  def name
    subject
  end

  def deliver
    notifier = MemberNotifier.new(user.phone_number)
    url = Pagerline::Application.routes.url_helpers.new_acknowledgement_url(notification_id: id)
    footer = "Ack @ #{url}"
    notifier.sms_message "#{subject} | #{footer}"

    ack = Acknowledgement.new user: user, notification: self
    ack_claim = ack.to_claim
    ack_url = Pagerline::Application.routes.url_helpers.twilio_acknowledgement_url(claim: ack_claim)
    notifier.voice_call subject, acknowledgement_url: ack_url
  end
end
