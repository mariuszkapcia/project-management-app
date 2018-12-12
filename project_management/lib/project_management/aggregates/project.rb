module ProjectManagement
  class Project
    include AggregateRoot

    DeadlineFromPast     = Class.new(StandardError)
    HoursPerWeekExceeded = Class.new(StandardError)

    def initialize(uuid)
      @uuid       = uuid
      @developers = []
    end

    def register(name)
      apply(ProjectManagement::ProjectRegistered.strict(data: {
        uuid: @uuid,
        name: name
      }))
    end

    def estimate(hours)
      apply(ProjectManagement::ProjectEstimated.strict(data: {
        uuid:  @uuid,
        hours: hours
      }))
    end

    def assign_deadline(deadline)
      raise DeadlineFromPast if deadline.to_date < Time.current.to_date

      apply(ProjectManagement::DeadlineAssignedToProject.strict(data: {
        uuid:     @uuid,
        deadline: deadline
      }))
    end

    def assign_developer(uuid, fullname)
      apply(ProjectManagement::DeveloperAssignedToProject.strict(data: {
        project_uuid:       @uuid,
        developer_uuid:     uuid,
        developer_fullname: fullname
      }))
    end

    def assign_developer_working_hours(developer_uuid, hours_per_week)
      raise HoursPerWeekExceeded if hours_per_week > 40

      apply(ProjectManagement::DeveloperWorkingHoursForProjectAssigned.strict(data: {
        project_uuid:   @uuid,
        developer_uuid: developer_uuid,
        hours_per_week: hours_per_week
      }))
    end

    private

    def apply_project_registered(event)
    end

    def apply_project_estimated(event)
    end

    def apply_developer_assigned_to_project(event)
      @developers << {
        uuid:     event.data[:developer_uuid],
        fullname: event.data[:developer_fullname]
      }
    end

    def apply_deadline_assigned_to_project(event)
    end

    def apply_developer_working_hours_for_project_assigned(event)
    end
  end
end
