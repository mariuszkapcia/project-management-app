event_store = Rails.configuration.event_store
projects_read_model = ProjectsReadModel.new
project_details_read_model = ProjectDetailsReadModel.new
developers_read_model = DevelopersReadModel.new

event_store.subscribe(
  ->(event) { projects_read_model.handle(event) },
  [
    ProjectManagement::ProjectRegistered
  ]
)

event_store.subscribe(
  ->(event) { project_details_read_model.handle(event) },
  [
    ProjectManagement::ProjectRegistered,
    ProjectManagement::ProjectEstimated,
    ProjectManagement::DeveloperAssignedToProject
  ]
)

event_store.subscribe(
  ->(event) { developers_read_model.handle(event) },
  [
    ProjectManagement::DeveloperRegistered
  ]
)
