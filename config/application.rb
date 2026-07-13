require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Server
  class Application < Rails::Application
    config.autoload_paths << "#{root}/app/views/forms"
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 8.1

    # Read legacy Marshal-serialized cookies, write JSON going forward.
    config.action_dispatch.cookies_serializer = :hybrid

    # The 7.0+ default variant processor is vips, which isn't installed;
    # mini_magick is already a dependency for label rendering.
    config.active_storage.variant_processor = :mini_magick

    routes.default_url_options = { host: 'localhost', port: 5000 }

    # Files from lib should be moved into a gem or the `./app/<something>` directory.
    config.autoload_paths << Rails.root.join('lib')
  end
end
