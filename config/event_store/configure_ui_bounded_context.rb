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
        ProjectManagement::ProjectEstimatedV2,
        ProjectManagement::DeadlineAssignedToProject,
        ProjectManagement::DeveloperAssignedToProject,
        ProjectManagement::DeveloperWorkingHoursForProjectAssigned
      ]
    )

    @event_store.subscribe(
      UI::ProjectApproximateEndReadModel,
      to: [
        ProjectManagement::ProjectRegistered,
        ProjectManagement::ProjectEstimatedV2,
        ProjectManagement::DeveloperWorkingHoursForProjectAssigned
      ]
    )

    @event_store.subscribe(
      UI::DeveloperListReadModel,
      to: [
        ProjectManagement::DeveloperRegistered
      ]
    )

    @event_store.subscribe(
      UI::NotificationListReadModel,
      to: [
        Notifications::ProjectKickoffEmailSent
      ]
    )
  end

  private

  def initialize(event_store: Rails.configuration.event_store)
    @event_store = event_store
  end
end
