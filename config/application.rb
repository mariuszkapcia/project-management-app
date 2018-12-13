require_relative 'boot'

require 'rails'
# Pick the frameworks you want:
require 'active_model/railtie'
require 'active_job/railtie'
require 'active_record/railtie'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'action_view/railtie'
# require 'action_cable/engine'
# require 'sprockets/railtie'
require 'rails/test_unit/railtie'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ProjectManagementApp
  class Application < Rails::Application
    config.load_defaults 5.1

    config.paths.add 'command/lib',            eager_load: true
    config.paths.add 'project_management/lib', eager_load: true
    config.paths.add 'ui/lib',                 eager_load: true

    config.api_only = true

    config.to_prepare do
      Rails.configuration.event_store = RailsEventStore::Client.new
    end
  end
end
