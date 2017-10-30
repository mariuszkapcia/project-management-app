require 'aggregate_root'

module Assignments
  class Project
    include AggregateRoot

    def initialize(uuid)
      @uuid = uuid
    end

    def register(name)

    end
  end
end
