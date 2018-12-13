require_dependency 'project_management'

require_relative '../support/test_attributes'
require_relative '../support/test_actors'

module ProjectManagement
  RSpec.describe 'ProjectsCommandHandler' do
    include TestAttributes
    include TestActors

    specify 'register a new project' do
      project = instance_of_project(event_store: event_store)
      project.register(project_topsecretdddproject)

      expect(event_store).to(have_published(project_registered))
    end

    specify 'estimate the project' do
      project = instance_of_project(event_store: event_store)
      project.register(project_topsecretdddproject)
      project.estimate(project_topsecretdddproject[:estimation])

      expect(event_store).to(have_published(project_estimated))
    end

    specify 'assign developer to the project' do
      # TODO: Pass faked DeveloperList read model to Projects command handler.
      developer = instance_of_developer(event_store: event_store)
      developer.register(developer_ignacy)

      project = instance_of_project(event_store: event_store)
      project.register(project_topsecretdddproject)
      project.assign_developer(developer_ignacy)

      expect(event_store).to(have_published(developer_assigned))
    end

    private

    def project_registered
      an_event(ProjectManagement::ProjectRegistered).with_data(project_registered_data).strict
    end

    def project_estimated
      an_event(ProjectManagement::ProjectEstimated).with_data(project_estimated_data).strict
    end

    def developer_assigned
      an_event(ProjectManagement::DeveloperAssignedToProject).with_data(developer_assigned_data).strict
    end

    def project_registered_data
      {
        uuid: project_topsecretdddproject[:uuid],
        name: project_topsecretdddproject[:name]
      }
    end

    def project_estimated_data
      {
        uuid:  project_topsecretdddproject[:uuid],
        hours: project_topsecretdddproject[:estimation]
      }
    end

    def developer_assigned_data
      {
        project_uuid:       project_topsecretdddproject[:uuid],
        developer_uuid:     developer_ignacy[:uuid],
        developer_fullname: developer_ignacy[:fullname]
      }
    end

    def event_store
      RailsEventStore::Client.new.tap do |es|
        ConfigureProjectManagementBoundedContext.new(event_store: es).call
      end
    end
  end
end
