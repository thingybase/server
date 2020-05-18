source 'https://rubygems.org'
ruby File.read(".ruby-version").chomp

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0.2', '>= 6.0.2.2'
# Use Puma as the app server
gem 'puma', '~> 4.1'
# Use SCSS for stylesheets
gem 'sass-rails', '>= 6'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 5.0'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
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
gem 'pg', '~> 1.1.0'
# Application error alerts
gem 'rollbar'
# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false

# Generate's PDFs, mostly for labels
gem "prawn", "~> 2.2"
# Print QR codes in a PDF
gem "prawn-qrcode", "~> 0.5.1"
gem "qrcode", "~> 0.0.1"
# Hierarchial record organization in ActiveRecord
gem "closure_tree", "~> 7.0"
# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
# Many models in one select
gem 'rails_polymorphic_select', github: 'bradgessler/rails_polymorphic_select'
# CSS framework
gem "bulma-rails", "~> 0.7.0"
# Parse natrual language date and time strings
gem "chronic", "~> 0.10.2"
# Search Postgres records
gem "pg_search", "~> 2.1"
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '~> 4.0'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails'
  gem 'faker'
  gem 'factory_bot_rails'
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
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'webdrivers'
end
