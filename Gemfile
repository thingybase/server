source 'https://rubygems.org'
ruby File.read(".ruby-version").chomp

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 7.0.0'
# Use Puma as the app server
gem 'puma', '~> 6.0'
# Use SCSS Gor stylesheets
gem 'sassc-rails'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.10'
# Use Redis adapter to run Action Cable in production
gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.13'
# HAML templates yo
gem 'haml-rails'
# Authorization libraries
gem 'omniauth'
gem 'omniauth-google-oauth2'
# Authorization logic
gem 'pundit'
# Form helper
gem 'simple_form', '~> 5.0'
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
gem 'pg', '~> 1.4'
# Application error alerts
gem 'rollbar'
# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false
# Generate's PDFs, mostly for labels
gem "prawn", "~> 2.0"
# Print QR codes in a PDF
gem "prawn-qrcode", "~> 0.5.0"
# Hierarchial record organization in ActiveRecord
gem "closure_tree", "~> 7.0"
# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
# Parse natrual language date and time strings
gem "chronic", "~> 0.10.2"
# Search Postgres records
gem "pg_search", "~> 2.3"
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '~> 5.3'
# Blanks from forms are converted into nil instead of stored as "" in the database
gem "nilify_blanks", "~> 1.4"
# Does union queries in ActiveRecord.
gem "active_record_union"
# Converts GUIDs in the URLs into shorter ids
gem "anybase", "~> 0.0.15"
# Pull this out when Rails 6.1 is a thing
gem "view_component", "~> 2.0"
# View template for CSV files
gem "csv_builder", "~> 2.1"
# Content management
if sitepress_gem_path = ENV["SITEPRESS_GEM_PATH"]
  gem "sitepress",        path: sitepress_gem_path
  gem "sitepress-cli",    path: sitepress_gem_path
  gem "sitepress-rails",  path: sitepress_gem_path
  gem "sitepress-core",   path: sitepress_gem_path
  gem "sitepress-server", path: sitepress_gem_path
else
  gem "sitepress-rails", github: "sitepress/sitepress", branch: "main"
end

# Markdown gem
gem "redcarpet", "~> 3.5.0"
# Parses SVG vector files and inverts them for darkmode.
gem "color", "~> 1.8"
# Used for reporting from the shell so I can see who signed up within a day/week
gem "groupdate", "~> 5.2"
# Render PDF file as an image to get around really annoying problems
# embedding PDFs in webpages or trying to embed them via PDF.js
gem "mini_magick", "~> 4.0.0"

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
  gem 'spring-commands-rspec'
end

group :test do
  gem 'pundit-matchers', '~> 1.7.0'
  gem 'shoulda-matchers', '~> 4.5.0'
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'webdrivers'
  gem 'rexml'
end

if featureomatic_path = ENV["FEATUREOMATIC_GEM_PATH"]
  gem "featureomatic", path: featureomatic_path
else
  gem "featureomatic", "~> 0.1.1", github: "rocketshipio/featureomatic"
end

gem "imageomatic", "~> 0.1.1", github: "imageomatic/ruby"

gem "mailto", "~> 0.1.1"

gem "stripe", "~> 5.38"

# Resource-oriented rails controllers
if oxidizer_peth = ENV["OXIDIZER_GEM_PATH"]
  gem "oxidizer", path: oxidizer_peth
else
  gem "oxidizer", github: "rocketshipio/oxidizer", branch: "main"
end

# No-password login flow
gem "nopassword", github: "rocketshipio/nopassword", branch: "main"
gem "matrix", "~> 0.4.2"

gem "ahoy_matey", "~> 4.1"

gem "slim-rails", "~> 3.5"

gem "blazer", "~> 2.6"

gem "turbo-rails", "~> 1.3"
