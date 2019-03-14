class ConfigureProjectManagementBoundedContext
  def call
    @event_store.subscribe(
      ProjectManagement::DeveloperList::Builder.new(event_store: @event_store),
      to: [
        ProjectManagement::DeveloperRegistered,
        ProjectManagement::DeveloperRemoved
      ]
    )

    @event_store.subscribe(
      ProjectManagement::DeveloperRemovedListener,
      to: [
        ProjectManagement::DeveloperRemoved
      ]
    )
  end

  private

  def initialize(event_store: Rails.configuration.event_store)
    @event_store = event_store
  end
end
