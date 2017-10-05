# Configure Twilio servive
Twilio.configure do |config|
  config.auth_token = ENV.fetch("TWILIO_AUTH_TOKEN", nil)
  config.account_sid = ENV.fetch("TWILIO_ACCOUNT_SID", nil)
end
