class SendNotificationJob < ApplicationJob
  queue_as :default
  include Pagerline::Application.routes.url_helpers

  def perform(notification)
    # TODO: Way too complex./ Move into classes n such.
    notification.team.users.where.not(phone_number: true).each do |user|
      phone_number = user.phone_number

      logger.info "Sending SMS to user #{phone_number}"
      notifier = MemberNotifier.new(phone_number)
      url = notification_url(notification)
      notifier.sms_message "Alert #{url} - #{notification.subject}"

      logger.info "Calling user #{phone_number}"
      ack = Acknowledgement.new user: user, notification: notification
      ack_claim = ack.to_claim
      ack_url = twilio_acknowledgement_url(claim: ack_claim, format: :xml)
      notifier.voice_call notification.subject, acknowledgement_url: ack_url
    end
  end
end
