class RegisterProjectService < ProjectsService
  def initialize(event_store:)
    @event_store = event_store
  end

  def call(command)
    with_project(command.uuid) do |project|
      project.register(command.name)
    end
  end
end
