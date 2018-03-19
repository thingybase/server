# Configure Twilio servive
Twilio.configure do |config|
  config.auth_token = ENV["TWILIO_AUTH_TOKEN"]
  config.account_sid = ENV["TWILIO_ACCOUNT_SID"]
end
