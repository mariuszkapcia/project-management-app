require_dependency 'project_management'

require_relative '../support/test_attributes'
require_relative '../support/test_actors'

module ProjectManagement
  RSpec.describe 'ProjectsCommandHandler' do
    include TestAttributes
    include TestActors

    cover 'ProjectManagement::ProjectsCommandHandler*'

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

    specify 'cannot assign non existing developer to the project' do
      project = instance_of_project(event_store: event_store)
      project.register(project_topsecretdddproject)

      expect do
        project.assign_developer(developer_ignacy)
      end.to raise_error(ProjectManagement::Project::DeveloperNotFound)
    end

    specify 'assign developer working hours in the project' do
      # TODO: Pass faked DeveloperList read model to Projects command handler.
      developer = instance_of_developer(event_store: event_store)
      developer.register(developer_ignacy)

      project = instance_of_project(event_store: event_store)
      project.register(project_topsecretdddproject)
      project.assign_developer(developer_ignacy)
      project.assign_developer_working_hours(developer_ignacy[:uuid], developer_ignacy[:hours_per_week])

      expect(event_store).to(have_published(developer_working_hours_for_project_assigned))
    end

    specify 'assign deadline to the project' do
      project = instance_of_project(event_store: event_store)
      project.register(project_topsecretdddproject)
      project.assign_deadline(project_topsecretdddproject[:deadline].to_i)

      expect(event_store).to(have_published(deadline_assigned_to_project))
    end

    specify 'kick off project' do
      project = instance_of_project(event_store: event_store)
      project.register(project_topsecretdddproject)
      project.estimate(project_topsecretdddproject[:estimation])
      project.assign_deadline(project_topsecretdddproject[:deadline].to_i)
      project.kick_off

      expect(event_store).to(have_published(project_kicked_off))
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

    def developer_working_hours_for_project_assigned
      an_event(ProjectManagement::DeveloperWorkingHoursForProjectAssigned)
        .with_data(developer_working_hours_for_project_assigned_data)
        .strict
    end

    def deadline_assigned_to_project
      an_event(ProjectManagement::DeadlineAssignedToProject).with_data(deadline_assigned_to_project_data).strict
    end

    def project_kicked_off
      an_event(ProjectManagement::ProjectKickedOff).with_data(project_kicked_off_data).strict
    end

    def project_registered_data
      {
        project_uuid: project_topsecretdddproject[:uuid],
        name:         project_topsecretdddproject[:name]
      }
    end

    def project_estimated_data
      {
        project_uuid: project_topsecretdddproject[:uuid],
        hours:        project_topsecretdddproject[:estimation]
      }
    end

    def developer_assigned_data
      {
        project_uuid:       project_topsecretdddproject[:uuid],
        developer_uuid:     developer_ignacy[:uuid],
        developer_fullname: developer_ignacy[:fullname]
      }
    end

    def developer_working_hours_for_project_assigned_data
      {
        project_uuid:   project_topsecretdddproject[:uuid],
        developer_uuid: developer_ignacy[:uuid],
        hours_per_week: developer_ignacy[:hours_per_week]
      }
    end

    def deadline_assigned_to_project_data
      {
        project_uuid: project_topsecretdddproject[:uuid],
        deadline:     project_topsecretdddproject[:deadline]
      }
    end

    def project_kicked_off_data
      {
        project_uuid: project_topsecretdddproject[:uuid]
      }
    end

    def event_store
      @event_store ||= begin
        RailsEventStore::Client.new.tap do |es|
          ConfigureProjectManagementBoundedContext.new(event_store: es).call
        end
      end
    end
  end
end
