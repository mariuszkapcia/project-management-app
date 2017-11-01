require 'aggregate_root'

module Assignments
  ProjectNotRegistered = Class.new(StandardError)

  class Project
    include AggregateRoot

    def initialize(uuid)
      @uuid  = uuid
      @state = :draft
    end

    def register(name)
      apply(Assignments::ProjectRegistered.new(data: {
        uuid: @uuid,
        name: name
      }))
    end

    def estimate(hours)
      raise Assignments::ProjectNotRegistered if @state == :draft

      apply(Assignments::ProjectEstimated.new(data: {
        uuid:  @uuid,
        hours: hours
      }))
    end

    private

    def apply_project_registered(event)
      @state = :registered
    end

    def apply_project_estimated(event)
    end
  end
end
