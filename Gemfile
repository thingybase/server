source 'https://rubygems.org'
ruby File.read(".ruby-version").chomp

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.0'
# Use Puma as the app server
gem 'puma', '~> 3.11'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'
# HAML templates yo
gem 'haml-rails'
# Authorization libraries
gem 'omniauth'
gem 'omniauth-google-oauth2'
# Authorization logic
gem 'pundit'
# Form helper
gem 'simple_form'
# Use jQuery with rails
# TODO: Can I remove this and use rails-ujs?
gem 'jquery-rails'
# Communicate with Twilio
gem 'twilio-ruby'
# Handle phone numbers as a propper data type (and normalize)
gem 'phony_rails'
# For claims to create resources in a phone ack
gem 'jwt'
# Validate password and token strengths based on entropy.
gem 'strong_password'
# Display times locally
gem 'local_time'
# Run Postgres in production
# TODO: Switch to 1.0.0 when Heroku figures out their compatability problems.
gem 'pg', '~> 0.21.0'
# Validate password entropy for strong passwords and secrets
gem 'strong_password'
# Application error alerts
gem 'rollbar'
# Faster dev boot times
gem 'bootsnap', '~> 1.3.0'

# Generate's PDFs, mostly for labels
gem "prawn", "~> 2.2"
# Remove Github reference when https://github.com/jabbrwcky/prawn-qrcode/pull/16 is released into a gem.
gem "prawn-qrcode", "~> 0.3.0", github: "jabbrwcky/prawn-qrcode"
gem "qrcode", "~> 0.0.1"

# Hierarchial record organization in ActiveRecord
gem "closure_tree", "~> 7.0"

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
  gem 'rspec-rails'
  gem 'faker'
  gem 'factory_bot_rails'
  gem 'sqlite3'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'pundit-matchers', '~> 1.3.1'
  gem 'shoulda-matchers', '~> 3.1'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

gem 'rails_polymorphic_select', github: 'brunopascoa/rails_polymorphic_select'

gem "bulma-rails", "~> 0.7.4"

gem "chronic", "~> 0.10.2"

gem "pg_search", "~> 2.1"
