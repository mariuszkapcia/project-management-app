module ProjectManagement
  class ProjectsCommandHandler
    def initialize(event_store:)
      @event_store = event_store
      @command_bus = Arkency::CommandBus.new
      {
        ProjectManagement::RegisterProject          => method(:register),
        ProjectManagement::EstimateProject          => method(:estimate),
        ProjectManagement::AssignDeveloperToProject => method(:assign_developer)
      }.map{ |klass, handler| @command_bus.register(klass, handler) }
    end

    def call(*commands)
      commands.each do |command|
        @command_bus.call(command)
      end
    end

    private

    def register(command)
      with_project(command.uuid) do |project|
        project.register(command.name)
      end
    end

    def estimate(command)
      with_project(command.uuid) do |project|
        project.estimate(command.hours)
      end
    end

    def assign_developer(command)
      with_project(command.project_uuid) do |project|
        project.assign_developer(command.developer_uuid, command.developer_fullname)
      end
    end

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
      "ProjectManagement::Project$#{project_uuid}"
    end
  end
end
