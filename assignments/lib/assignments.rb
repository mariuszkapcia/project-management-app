module Assignments
  # Commands
  class RegisterProject
    attr_accessor :uuid
    attr_accessor :name

    def initialize(uuid:, name:)
      @uuid = uuid
      @name = name
    end
  end

  class EstimateProject
    attr_accessor :uuid
    attr_accessor :hours

    def initialize(uuid:, hours:)
      @uuid  = uuid
      @hours = hours
    end
  end

  class RegisterDeveloper
    attr_accessor :uuid
    attr_accessor :fullname
    attr_accessor :email

    def initialize(uuid:, fullname:, email:)
      @uuid     = uuid
      @fullname = fullname
      @email    = email
    end
  end

  # Domain Events
  class ProjectRegistered < RailsEventStore::Event
  end

  class ProjectEstimated < RailsEventStore::Event
  end

  class DeveloperRegistered < RailsEventStore::Event
  end

  class DeveloperAssignedToProject < RailsEventStore::Event
  end
end

require_dependency 'assignments/project_services'
require_dependency 'assignments/developer_services'
