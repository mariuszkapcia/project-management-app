class ConfigureAccountingBoundedContext
  def call
  end

  private

  def initialize(event_store: Rails.configuration.event_store)
    @event_store = event_store
  end
end
