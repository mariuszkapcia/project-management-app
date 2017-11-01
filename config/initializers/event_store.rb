event_store = Rails.configuration.event_store
projects_read_model = ProjectsReadModel.new
project_details_read_model = ProjectDetailsReadModel.new

event_store.subscribe(
  ->(event) { projects_read_model.handle(event) },
  [
    Assignments::ProjectRegistered
  ]
)

event_store.subscribe(
  ->(event) { project_details_read_model.handle(event) },
  [
    Assignments::ProjectRegistered,
    Assignments::ProjectEstimated
  ]
)
