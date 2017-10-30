module Assignments
  # Commands
  class RegisterProject
    attr_accessor :uuid
    attr_accessor :name

    def initialize(uuid, name)
      @uuid = uuid
      @name = name
    end
  end

  # Domain Events
  class ProjectRegistered < RailsEventStore::Event
  end
end

require_dependency 'assignments/project_services'
