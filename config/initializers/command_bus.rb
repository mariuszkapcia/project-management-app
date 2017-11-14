command_bus = Rails.configuration.command_bus
event_store = Rails.configuration.event_store

command_bus.register(
  ProjectManagement::RegisterProject,
  RegisterProjectService.new(event_store: event_store)
)

command_bus.register(
  ProjectManagement::EstimateProject,
  EstimateProjectService.new(event_store: event_store)
)

command_bus.register(
  ProjectManagement::AssignDeveloperToProject,
  AssignDeveloperToProjectService.new(event_store: event_store)
)
