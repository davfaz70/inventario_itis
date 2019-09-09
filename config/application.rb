require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

#Dotenv::Railtie.load

module ItisTorricelli
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
		# -- all .rb files in that directory are automatically loaded after loading
		# the framework and any gems in your application.

    config.active_job.queue_adapter = :delayed_job

    config.time_zone='Rome'
    config.i18n.available_locales = [:en, :it]
    config.i18n.default_locale = :it
  #  config.action_mailer.default_url_options = { host: '192.168.1.7' }
  #  config.i18n.fallbacks = [I18n.default_locale]

    # Where the I18n library should search for translation files





  end
end
