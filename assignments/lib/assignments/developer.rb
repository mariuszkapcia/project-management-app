require 'aggregate_root'

module Assignments
  class Developer
    include AggregateRoot

    def initialize(uuid)
      @uuid = uuid
    end

    def register(fullname, email)
      apply(Assignments::DeveloperRegistered.new(data: {
        uuid:     @uuid,
        fullname: fullname,
        email:    email
      }))
    end

    private

    def apply_developer_registered(event)
    end
  end
end
