# frozen_string_literal: true

require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Daryllxd
  class Application < Rails::Application
    config.autoload_paths += %W[#{config.root}/lib #{Rails.root.join('app', 'graphs', 'types')}]

    config.generators do |g|
      g.test_framework(
        :rspec,
        fixtures: true, view_specs: false, helper_specs: false,
        routing_specs: false, controller_specs: false,
        request_specs: false
      )
      g.fixture_replacement :factory_girl, dir: 'spec/factories', suffix: 'factory'
    end

    config.action_controller.permit_all_parameters = true

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = 'America/New_York'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins '*'
        resource '*', headers: :any, methods: %i[get post options]
      end
    end
  end
end
