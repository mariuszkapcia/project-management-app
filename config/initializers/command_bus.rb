command_bus = Rails.configuration.command_bus
event_store = Rails.configuration.event_store

command_bus.register(
  ProjectManagement::RegisterProject,
  ProjectManagement::RegisterProjectService.new(event_store: event_store)
)

command_bus.register(
  ProjectManagement::EstimateProject,
  ProjectManagement::EstimateProjectService.new(event_store: event_store)
)

command_bus.register(
  ProjectManagement::AssignDeveloperToProject,
  ProjectManagement::AssignDeveloperToProjectService.new(event_store: event_store)
)

command_bus.register(
  ProjectManagement::RegisterDeveloper,
  ProjectManagement::RegisterDeveloperService.new(event_store: event_store)
)
