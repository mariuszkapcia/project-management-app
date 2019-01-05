class ConfigureProjectKickoffProcessManager
  def call
    @event_store.subscribe(
      ProjectManagement::ProjectKickoff,
      to: [
        ProjectManagement::ProjectRegistered,
        ProjectManagement::ProjectEstimated,
        ProjectManagement::DeadlineAssignedToProject
      ]
    )
  end

  private

  def initialize(event_store: Rails.configuration.event_store)
    @event_store = event_store
  end
end
