require 'aggregate_root'

class ProjectService

  private

  def with_project(uuid)
    ProjectManagement::Project.new(uuid).tap do |project|
      load_project(uuid, project)
      yield(project)
      store_project(project)
    end
  end

  def load_project(project_uuid, project)
    project.load(stream_name(project_uuid), event_store: @event_store)
  end

  def store_project(project)
    project.store(event_store: @event_store)
  end

  def stream_name(project_uuid)
    "Project$#{project_uuid}"
  end
end
