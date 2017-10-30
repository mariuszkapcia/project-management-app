class ApplicationController < ActionController::API

  private

  def event_store
    @event_store ||= Rails.configuration.event_store.tap do |client|
      configure_event_handlers(client)
    end
  end

  def configure_event_handlers(client)
  end

  def command_bus
    @command_bus ||= Arkency::CommandBus.new.tap do |command_bus|
      configure_command_handlers(command_bus)
    end
  end

  def configure_command_handlers(command_bus)

  end
end
