require 'aggregate_root'

module Assignments
  class ProjectService

    private

    def with_project(uuid)
      Project.new(uuid).tap do |project|
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

  class RegisterProjectService < ProjectService
    def initialize(event_store)
      @event_store = event_store
    end

    def call(command)
      with_project(command.uuid) do |project|
        project.register(command.name)
      end
    end
  end
end
