require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ProjectManagementApp
  class Application < Rails::Application
    config.load_defaults 5.1

    config.paths.add 'lib/',                   eager_load: true
    config.paths.add 'command/lib',            eager_load: true
    config.paths.add 'project_management/lib', eager_load: true
    config.paths.add 'notifications/lib',      eager_load: true
    config.paths.add 'ui/lib',                 eager_load: true
  end
end
