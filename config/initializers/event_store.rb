event_store = Rails.configuration.event_store
projects_read_model = ProjectsReadModel.new

event_store.subscribe(
  ->(event) { projects_read_model.handle(event) },
  [
    Assignments::ProjectRegistered,
    Assignments::ProjectEstimated
  ]
)
