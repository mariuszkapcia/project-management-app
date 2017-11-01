class ApplicationController < ActionController::API

  private

  def event_store
    @event_store ||= Rails.configuration.event_store.tap do |client|
      configure_event_handlers(client)
    end
  end

  def configure_event_handlers(client)
    client.subscribe(
      ->(event) { projects_read_model.handle(event) },
      [
        Assignments::ProjectRegistered
      ]
    )
  end

  def command_bus
    @command_bus ||= Arkency::CommandBus.new.tap do |command_bus|
      configure_command_handlers(command_bus)
    end
  end

  def configure_command_handlers(command_bus)
    command_bus.register(
      Assignments::RegisterProject,
      Assignments::RegisterProjectService.new(event_store: event_store)
    )
  end

  def projects_read_model
    @projects_read_model ||= ProjectsReadModel.new
  end
end
