module ProjectManagement
  class ProjectsCommandHandler
    def initialize(event_store:)
      @event_store               = event_store
      @developer_list_read_model = DeveloperList::Retriever.new(event_store: @event_store)
      @command_bus               = Arkency::CommandBus.new
      {
        ProjectManagement::RegisterProject             => method(:register),
        ProjectManagement::EstimateProject             => method(:estimate),
        ProjectManagement::AssignDeveloperToProject    => method(:assign_developer),
        ProjectManagement::AssignDeveloperWorkingHours => method(:assign_developer_working_hours),
        ProjectManagement::AssignDeadline              => method(:assign_deadline),
        ProjectManagement::KickOffProject              => method(:kick_off_project)
      }.map{ |klass, handler| @command_bus.register(klass, handler) }
    end

    def call(*commands)
      commands.each do |command|
        @command_bus.call(command)
      end
    end

    private

    def register(cmd)
      cmd.verify!

      ActiveRecord::Base.transaction do
        with_project(cmd.project_uuid) do |project|
          project.register(cmd.name)
        end
      end
    end

    def estimate(cmd)
      cmd.verify!

      ActiveRecord::Base.transaction do
        with_project(cmd.project_uuid) do |project|
          project.estimate(cmd.hours)
        end
      end
    end

    def assign_developer(cmd)
      cmd.verify!

      raise Project::DeveloperNotFound unless @developer_list_read_model.retrieve.exists?(cmd.developer_uuid)

      ActiveRecord::Base.transaction do
        with_project(cmd.project_uuid) do |project|
          project.assign_developer(cmd.developer_uuid, cmd.developer_fullname)
        end
      end
    end

    def assign_developer_working_hours(cmd)
      cmd.verify!

      ActiveRecord::Base.transaction do
        with_project(cmd.project_uuid) do |project|
          project.assign_developer_working_hours(cmd.developer_uuid, cmd.hours_per_week)
        end
      end
    end

    def assign_deadline(cmd)
      cmd.verify!

      deadline = Deadline.new(cmd.deadline)

      ActiveRecord::Base.transaction do
        with_project(cmd.project_uuid) do |project|
          project.assign_deadline(deadline)
        end
      end
    end

    def kick_off_project(cmd)
      cmd.verify!

      ActiveRecord::Base.transaction do
        with_project(cmd.project_uuid) do |project|
          project.kick_off
        end
      end
    end

    def with_project(project_uuid)
      repository = AggregateRoot::Repository.new(@event_store)
      project    = Project.new(project_uuid)
      repository.with_aggregate(project, stream_name(project_uuid)) do |project|
        yield project
      end
    end

    def stream_name(project_uuid)
      "ProjectManagement::Project$#{project_uuid}"
    end
  end
end
