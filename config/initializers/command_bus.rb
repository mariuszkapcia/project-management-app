command_bus = Rails.configuration.command_bus
event_store = Rails.configuration.event_store

command_bus.register(
  Assignments::RegisterProject,
  Assignments::RegisterProjectService.new(event_store: event_store)
)

command_bus.register(
  Assignments::EstimateProject,
  Assignments::EstimateProjectService.new(event_store: event_store)
)
