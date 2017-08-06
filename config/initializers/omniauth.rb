Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer unless Rails.env.production?
  # TODO: Add Github & Google
  # provider :twitter, ENV['TWITTER_KEY'], ENV['TWITTER_SECRET']
end
