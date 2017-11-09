class AssignDeveloperToProjectService < ProjectsService
  def initialize(event_store:)
    @event_store = event_store
  end

  def call(command)
    with_project(command.project_uuid) do |project|
      project.assign_developer(command.developer_uuid, command.developer_fullname)
    end
  end
end
