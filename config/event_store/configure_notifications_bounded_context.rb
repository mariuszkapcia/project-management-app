class ConfigureNotificationsBoundedContext
  def call
    @event_store.subscribe(
      Notifications::ProjectKickedOffHandler,
      to: [
        ProjectManagement::ProjectKickedOff
      ]
    )
  end

  private

  def initialize(event_store: Rails.configuration.event_store)
    @event_store = event_store
  end
end
