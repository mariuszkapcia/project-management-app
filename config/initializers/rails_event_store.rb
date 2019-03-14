require 'rails_event_store'
require 'aggregate_root'
require 'arkency/command_bus'

require_relative '../event_store/configure_project_management_bounded_context'
require_relative '../event_store/configure_notifications_bounded_context'
require_relative '../event_store/configure_ui_bounded_context'

require_relative '../event_store/configure_project_kickoff_process_manager'

Rails.configuration.to_prepare do
  Rails.configuration.command_bus = command_bus = Arkency::CommandBus.new
  Rails.configuration.event_store = event_store = RailsEventStore::Client.new(
    dispatcher: RubyEventStore::ComposedDispatcher.new(
      RailsEventStore::AfterCommitAsyncDispatcher.new(scheduler: RailsEventStore::ActiveJobScheduler.new),
      RubyEventStore::PubSub::Dispatcher.new
    ),
    mapper: ComposedMapper.new(
      UpcastingMapper.new,
      RubyEventStore::Mappers::Default.new
    )
  )

  AggregateRoot.configure do |config|
    config.default_event_store = event_store
  end

  # NOTE: Global command bus for process managers and sagas.
  command_bus.register(
    ProjectManagement::KickOffProject,
    ProjectManagement::ProjectsCommandHandler.new(event_store: event_store)
  )

  ConfigureProjectManagementBoundedContext.new(event_store: event_store).call
  ConfigureNotificationsBoundedContext.new(event_store: event_store).call
  ConfigureUIBoundedContext.new(event_store: event_store).call

  ConfigureProjectKickoffProcessManager.new(event_store: event_store).call
end
