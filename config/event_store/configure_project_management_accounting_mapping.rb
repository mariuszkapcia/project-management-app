class ConfigureProjectManagementAccountingMapping
  def call
    @event_store.subscribe(
      ProjectManagementAccountingMapping::ProjectRegisteredHandler,
      to: [
        ProjectManagement::ProjectRegistered
      ]
    )
  end

  private

  def initialize(event_store: Rails.configuration.event_store)
    @event_store = event_store
  end
end
