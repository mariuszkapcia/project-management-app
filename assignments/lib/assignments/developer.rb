require 'aggregate_root'

module Assignments
  class Developer
    include AggregateRoot

    def initialize(uuid)
      @uuid = uuid
    end

    def register(name)
      apply(Assignments::DeveloperRegistered.new(data: {
        uuid: @uuid,
        name: name
      }))
    end

    private

    def apply_developer_registered(event)
    end
  end
end
