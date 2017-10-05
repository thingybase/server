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
    message = "#{subject} | #{footer}"
    notifier.sms_message message
  end
end
