require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

def set_locate_configs_and_timezone
  config.time_zone = 'Brasilia'
  # Use only default Rails locales to avoid pluralization issues
  config.i18n.available_locales = [:en]
  config.i18n.default_locale = :en
  config.i18n.fallbacks = true
end

module AssisTech
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0
    set_locate_configs_and_timezone #pt-BR
    # Configuration for the application, engines, and railties goes here.
    # config.api_only = true  # Disabled for full web application
    config.middleware.use ActionDispatch::Cookies
    config.middleware.use ActionDispatch::Session::CookieStore, key: '_your_app_session'
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
  end
end
