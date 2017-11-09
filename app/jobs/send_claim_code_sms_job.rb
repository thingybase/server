class SendClaimCodeSmsJob < ApplicationJob
  queue_as :default

  def perform(claim)
    MemberNotifier.new(claim.phone_number).sms_message("Your verification code is #{claim.code}")
    # Do something later
  end
end
