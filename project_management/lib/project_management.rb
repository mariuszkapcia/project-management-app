module ProjectManagement
  # Commands
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

require_dependency 'project_management/commands/register_project.rb'
require_dependency 'project_management/commands/estimate_project.rb'
require_dependency 'project_management/commands/assign_developer_to_project.rb'

require_dependency 'project_management/project_services'
require_dependency 'project_management/developer_services'
