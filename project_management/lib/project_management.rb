module ProjectManagement
end

require_dependency 'project_management/commands/register_project.rb'
require_dependency 'project_management/commands/estimate_project.rb'
require_dependency 'project_management/commands/assign_developer_to_project.rb'
require_dependency 'project_management/commands/register_developer.rb'

require_dependency 'project_management/domain_events/project_registered.rb'
require_dependency 'project_management/domain_events/project_estimated.rb'
require_dependency 'project_management/domain_events/developer_registered.rb'
require_dependency 'project_management/domain_events/developer_assigned_to_project.rb'

require_dependency 'project_management/aggregates/developer.rb'
require_dependency 'project_management/aggregates/project.rb'
