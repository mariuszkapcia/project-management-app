require 'aggregate_root'

module Assignments
  class Project
    include AggregateRoot

    def initialize(uuid)
      @uuid  = uuid
    end

    def register(name)
      apply(Assignments::ProjectRegistered.new(data: {
        uuid: @uuid,
        name: name
      }))
    end

    def estimate(hours)
      apply(Assignments::ProjectEstimated.new(data: {
        uuid:  @uuid,
        hours: hours
      }))
    end

    private

    def apply_project_registered(event)
    end

    def apply_project_estimated(event)
    end
  end
end
