source 'https://rubygems.org'

ruby file: ".ruby-version"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', github: 'rails/rails'
# Use Puma as the app server
gem 'puma', '~> 6.0'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.10'
# Use Redis adapter to run Action Cable in production
gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.13'
# Authorization libraries
gem 'omniauth'
gem 'omniauth-google-oauth2'
# Authorization logic
gem 'pundit'
# Form helper
gem 'simple_form', '~> 5.0'

# JWT token handling for authentication
gem 'jwt'
# Validate password and token strengths based on entropy.
gem 'strong_password'
# Display times locally
gem 'local_time'
# Run Postgres in production
gem 'pg', '~> 1.5'
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
# Blanks from forms are converted into nil instead of stored as "" in the database
gem "nilify_blanks", "~> 1.4"
# Does union queries in ActiveRecord.
# Remove from Github when 1.3.1 is released. Issue at https://github.com/brianhempel/active_record_union/issues/36
gem "active_record_union", "~> 1.3.0", github: "brianhempel/active_record_union"
# Converts GUIDs in the URLs into shorter ids
gem "anybase", "~> 0.0.15"
# View template for CSV files
gem "csv_builder", "~> 2.1"

# Content management
# if sitepress_gem_path = ENV["SITEPRESS_GEM_PATH"]
#   gem "sitepress",        path: sitepress_gem_path
#   gem "sitepress-cli",    path: sitepress_gem_path
#   gem "sitepress-rails",  path: sitepress_gem_path
#   gem "sitepress-core",   path: sitepress_gem_path
#   gem "sitepress-server", path: sitepress_gem_path
# else
#   gem "sitepress-rails", github: "sitepress/sitepress", branch: "main"
# end
#
gem "sitepress-rails", "~> 4.0"

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
  gem 'web-console'#, '>= 3.3.0'
  # gem 'listen'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen'#, '~> 2.0.0'
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
  gem "featureomatic", "~> 0.1.1", github: "rubymonolith/featureomatic"
end

# gem "tinyzap", github: "tinyzap/ruby"

gem "mailto", "~> 0.1"

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

gem "ahoy_matey", "~> 5.4"

gem "blazer", "~> 2.6"

gem "imageomatic", "~> 0.1.4"

# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem "importmap-rails"

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "turbo-rails"

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "stimulus-rails"

# The modern asset pipeline for Rails [https://github.com/rails/propshaft]
gem "propshaft"

# Components!

gem "csv"

gem "phlex-rails", "~> 2.3"

gem "superview", "~> 1.0"

gem "superform", "~> 0.6.0"

gem "tailwindcss-rails", "~> 4.3"
