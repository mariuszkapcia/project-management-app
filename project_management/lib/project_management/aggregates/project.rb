require 'aggregate_root'

module ProjectManagement
  DeadlineFromPast = Class.new(StandardError)

  class Project
    include AggregateRoot

    def initialize(uuid)
      @uuid       = uuid
      @developers = []
    end

    def register(name)
      apply(ProjectManagement::ProjectRegistered.new(data: {
        uuid: @uuid,
        name: name
      }))
    end

    def estimate(hours)
      apply(ProjectManagement::ProjectEstimated.new(data: {
        uuid:  @uuid,
        hours: hours
      }))
    end

    def assign_deadline(deadline)
      raise DeadlineFromPast if deadline.to_date < Time.current.to_date

      apply(ProjectManagement::DeadlineAssignedToProject.new(data: {
        uuid:     @uuid,
        deadline: deadline
      }))
    end

    def assign_developer(uuid, fullname)
      apply(ProjectManagement::DeveloperAssignedToProject.new(data: {
        project_uuid:       @uuid,
        developer_uuid:     uuid,
        developer_fullname: fullname
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
  end
end
