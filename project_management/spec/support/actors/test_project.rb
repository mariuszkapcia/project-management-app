module ProjectManagement
  class TestProject
    def register(project)
      @uuid = project[:uuid]

      @command_handler
        .new(event_store: @event_store)
        .call(
          ProjectManagement::RegisterProject.new(
            project_uuid: project[:uuid],
            name:         project[:name]
          )
        )
    end

    def estimate(estimation)
      @command_handler
        .new(event_store: @event_store)
        .call(
          ProjectManagement::EstimateProject.new(
            project_uuid: @uuid,
            hours:        estimation
          )
        )
    end

    def assign_developer(developer)
      @command_handler
        .new(event_store: @event_store)
        .call(
          ProjectManagement::AssignDeveloperToProject.new(
            project_uuid:       @uuid,
            developer_uuid:     developer[:uuid],
            developer_fullname: developer[:fullname]
          )
        )
    end

    def assign_developer_working_hours(developer_uuid, hours_per_week)
      @command_handler
        .new(event_store: @event_store)
        .call(
          ProjectManagement::AssignDeveloperWorkingHours.new(
            project_uuid:   @uuid,
            developer_uuid: developer_uuid,
            hours_per_week: hours_per_week
          )
        )
    end

    def assign_deadline(deadline)
      @command_handler
        .new(event_store: @event_store)
        .call(
          ProjectManagement::AssignDeadline.new(
            project_uuid: @uuid,
            deadline:     deadline
          )
        )
    end

    private

    def initialize(event_store: Rails.configuration.event_store)
      @uuid            = nil
      @event_store     = event_store
      @command_handler = ProjectManagement::ProjectsCommandHandler
    end
  end
end
