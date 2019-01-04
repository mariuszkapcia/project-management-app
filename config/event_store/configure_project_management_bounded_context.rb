class ConfigureProjectManagementBoundedContext
  def call
    @event_store.subscribe(
      ProjectManagement::DeveloperList::Builder.new(event_store: @event_store),
      to: [
        ProjectManagement::DeveloperRegistered
      ]
    )

    @event_store.subscribe(
      ProjectManagement::ProjectKickoff.new(event_store: @event_store, command_bus: @command_bus),
      to: [
        ProjectManagement::ProjectRegistered,
        ProjectManagement::ProjectEstimated,
        ProjectManagement::DeadlineAssignedToProject
      ]
    )
  end

  private

  def initialize(event_store: Rails.configuration.event_store, command_bus: Rails.configuration.command_bus)
    @event_store = event_store
    @command_bus = command_bus
  end
end
