Rails.configuration.to_prepare do
  Rails.configuration.event_store.tap do |es|
    es.subscribe(
      ProjectsReadModel,
      to: [
        ProjectManagement::ProjectRegistered
      ]
    )

    es.subscribe(
      ProjectDetailsReadModel,
      to: [
        ProjectManagement::ProjectRegistered,
        ProjectManagement::ProjectEstimated,
        ProjectManagement::DeveloperAssignedToProject
      ]
    )

    es.subscribe(
      DevelopersReadModel,
      to: [
        ProjectManagement::DeveloperRegistered
      ]
    )
  end
end
