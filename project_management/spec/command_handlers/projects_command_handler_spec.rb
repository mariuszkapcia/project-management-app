require_dependency 'project_management'

module ProjectManagement
  RSpec.describe 'ProjectsService' do
    specify 'register a new project' do
      ProjectManagement::ProjectsCommandHandler
        .new(event_store: event_store)
        .call(
          ProjectManagement::RegisterProject.new(
            uuid: project_uuid,
            name: 'awesome_project')
        )

        expect(event_store).to(have_published(project_registered))
    end

    specify 'estimate the project' do
      ProjectManagement::ProjectsCommandHandler
        .new(event_store: event_store)
        .call(
          ProjectManagement::RegisterProject.new(
            uuid: project_uuid,
            name: project_name),
          ProjectManagement::EstimateProject.new(
            uuid: project_uuid,
            hours: project_estimation)
        )

      expect(event_store).to(have_published(project_estimated))
    end

    specify 'assign developer to the project' do
      ProjectManagement::ProjectsCommandHandler
        .new(event_store: event_store)
        .call(
          ProjectManagement::RegisterProject.new(
            uuid: project_uuid,
            name: project_name)
        )

      ProjectManagement::ProjectsCommandHandler
        .new(event_store: event_store)
        .call(
          ProjectManagement::AssignDeveloperToProject.new(
            project_uuid:       project_uuid,
            developer_uuid:     developer_uuid,
            developer_fullname: developer_fullname)
        )

        expect(event_store).to(have_published(developer_assigned))
    end

    private

    def project_registered
      an_event(ProjectManagement::ProjectRegistered).with_data(project_data)
    end

    def project_estimated
      an_event(ProjectManagement::ProjectEstimated).with_data(estimate_data)
    end

    def developer_assigned
      an_event(ProjectManagement::DeveloperAssignedToProject).with_data(developer_assigned_data)
    end

    def project_data
      {
        uuid: project_uuid,
        name: project_name
      }
    end

    def estimate_data
      {
        uuid:  project_uuid,
        hours: project_estimation
      }
    end

    def developer_assigned_data
      {
        project_uuid:       project_uuid,
        developer_uuid:     developer_uuid,
        developer_fullname: developer_fullname
      }
    end

    def project_uuid
      'cfaf0e8e-e40e-4068-be27-dd42a30d9b0d'
    end

    def project_name
      'awesome_project'
    end

    def project_estimation
      40
    end

    def developer_uuid
      'fcd7eb2f-135d-4630-ae05-00f1ac577cd2'
    end

    def developer_fullname
      'Ignacy Ignacy'
    end

    def event_store
      Rails.configuration.event_store
    end
  end
end
