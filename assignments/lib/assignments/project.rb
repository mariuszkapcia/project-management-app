require 'aggregate_root'

module Assignments
  class Project
    include AggregateRoot

    def initialize(uuid)
      @uuid = uuid
    end

    def register(name)
      apply(Assignments::ProjectRegistered.new(data: {
        uuid: @uuid,
        name: name
      }))
    end

    private

    def apply_project_registered(event)
    end
  end
end
