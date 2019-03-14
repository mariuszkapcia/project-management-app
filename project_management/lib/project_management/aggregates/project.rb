module ProjectManagement
  class Project
    include AggregateRoot

    HasBeenAlreadyRegistered = Class.new(StandardError)
    DeadlineFromPast         = Class.new(StandardError)
    HoursPerWeekExceeded     = Class.new(StandardError)
    DeveloperAlreadyAssigned = Class.new(StandardError)
    DeveloperNotFound        = Class.new(StandardError)
    InvalidEstimation        = Class.new(StandardError)
    InvalidWorkingHours      = Class.new(StandardError)
    NotReadyForKickOff       = Class.new(StandardError)

    def initialize(uuid)
      @uuid                = uuid
      @state               = nil
      @developers          = []
      @estimation_provided = false
      @deadline_provided   = false
    end

    def register(name)
      raise HasBeenAlreadyRegistered if @state == :registered

      apply(ProjectManagement::ProjectRegistered.strict(data: {
        project_uuid: @uuid,
        name:         name
      }))
    end

    # TODO: Handle story_points properly.
    def estimate(hours)
      raise InvalidEstimation if hours < 0

      apply(ProjectManagement::ProjectEstimatedV2.strict(data: {
        project_uuid: @uuid,
        hours:        hours,
        story_points: 0
      }))
    end

    def assign_deadline(deadline)
      raise DeadlineFromPast if deadline < Deadline.new(DateTime.current.to_i)

      apply(ProjectManagement::DeadlineAssignedToProject.strict(data: {
        project_uuid: @uuid,
        deadline:     deadline.to_datetime
      }))
    end

    def assign_developer(uuid, fullname)
      raise DeveloperAlreadyAssigned if @developers.any? { |developer| developer[:uuid] == uuid }

      apply(ProjectManagement::DeveloperAssignedToProject.strict(data: {
        project_uuid:       @uuid,
        developer_uuid:     uuid,
        developer_fullname: fullname
      }))
    end

    def assign_developer_working_hours(developer_uuid, hours_per_week)
      raise DeveloperNotFound unless @developers.any? { |developer| developer[:uuid] == developer_uuid }
      raise InvalidWorkingHours if hours_per_week < 0
      raise HoursPerWeekExceeded if hours_per_week > 40

      apply(ProjectManagement::DeveloperWorkingHoursForProjectAssigned.strict(data: {
        project_uuid:   @uuid,
        developer_uuid: developer_uuid,
        hours_per_week: hours_per_week
      }))
    end

    def kick_off
      raise NotReadyForKickOff if !@estimation_provided || !@deadline_provided

      apply(ProjectManagement::ProjectKickedOff.strict(data: {
        project_uuid: @uuid
      }))
    end

    private

    def apply_project_registered(event)
      @state = :registered
    end

    def apply_project_estimated_v2(event)
      @estimation_provided = true
    end

    def apply_developer_assigned_to_project(event)
      @developers << {
        uuid:     event.data[:developer_uuid],
        fullname: event.data[:developer_fullname]
      }
    end

    def apply_deadline_assigned_to_project(event)
      @deadline_provided = true
    end

    def apply_developer_working_hours_for_project_assigned(event)
    end

    def apply_project_kicked_off(event)
      @state = :kicked_off
    end
  end
end
