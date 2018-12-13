class ConfigureUIBoundedContext
  def call
    @event_store.subscribe(
      UI::ProjectListReadModel,
      to: [
        ProjectManagement::ProjectRegistered
      ]
    )

    @event_store.subscribe(
      UI::ProjectDetailsReadModel,
      to: [
        ProjectManagement::ProjectRegistered,
        ProjectManagement::ProjectEstimated,
        ProjectManagement::DeveloperAssignedToProject,
        ProjectManagement::DeveloperWorkingHoursForProjectAssigned
      ]
    )

    @event_store.subscribe(
      UI::DeveloperListReadModel,
      to: [
        ProjectManagement::DeveloperRegistered
      ]
    )
  end

  private

  def initialize(event_store: Rails.configuration.event_store)
    @event_store = event_store
  end
end
