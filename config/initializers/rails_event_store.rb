Rails.configuration.to_prepare do
  Rails.configuration.event_store.tap do |es|
    es.subscribe(
      UI::ProjectListReadModel,
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
      UI::DeveloperListReadModel,
      to: [
        ProjectManagement::DeveloperRegistered
      ]
    )
  end
end
