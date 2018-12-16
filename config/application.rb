require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ProjectManagementApp
  class Application < Rails::Application
    config.load_defaults 5.1

    config.paths.add 'command/lib',            eager_load: true
    config.paths.add 'accounting/lib',         eager_load: true
    config.paths.add 'project_management/lib', eager_load: true
    config.paths.add 'ui/lib',                 eager_load: true

    config.paths.add 'project_management_accounting_mapping/lib', eager_load: true

    config.to_prepare do
      Rails.configuration.event_store = RailsEventStore::Client.new(
        dispatcher: RubyEventStore::ComposedDispatcher.new(
          RailsEventStore::AfterCommitAsyncDispatcher.new(scheduler: RailsEventStore::ActiveJobScheduler.new),
          RubyEventStore::PubSub::Dispatcher.new
        )
      )
    end
  end
end
