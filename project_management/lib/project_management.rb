module ProjectManagement
  # Domain Events
  class DeveloperRegistered < RailsEventStore::Event
  end

  class DeveloperAssignedToProject < RailsEventStore::Event
  end
end

require_dependency 'project_management/commands/register_project.rb'
require_dependency 'project_management/commands/estimate_project.rb'
require_dependency 'project_management/commands/assign_developer_to_project.rb'
require_dependency 'project_management/commands/register_developer.rb'

require_dependency 'project_management/domain_events/project_registered.rb'
require_dependency 'project_management/domain_events/project_estimated.rb'

require_dependency 'project_management/project_services'
require_dependency 'project_management/developer_services'
