class ConfigureNotificationsBoundedContext
  def call
    @event_store.subscribe(
      Notifications::ProjectList::Builder.new(event_store: @event_store),
      to: [
        ProjectManagement::ProjectRegistered
      ]
    )

    @event_store.subscribe(
      Notifications::ProjectKickedOffHandler.new(event_store: @event_store),
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
