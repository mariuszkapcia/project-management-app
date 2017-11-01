require_dependency 'assignments'

module Assignments
  RSpec.describe 'Project services' do
    specify 'register a new project' do
      Assignments::RegisterProjectService
        .new(event_store: event_store)
        .call(Assignments::RegisterProject.new(
          uuid: project_uuid,
          name: 'awesome_project'
        ))

        expect(event_store).to(have_published(project_registered))
    end

    specify 'estimate the project' do
      Assignments::RegisterProjectService
        .new(event_store: event_store)
        .call(Assignments::RegisterProject.new(
          uuid: project_uuid,
          name: project_name
        ))

      Assignments::EstimateProjectService
        .new(event_store: event_store)
        .call(Assignments::EstimateProject.new(
          uuid: project_uuid,
          hours: project_estimation
        ))

      expect(event_store).to(have_published(project_estimated))
    end

    private

    def project_registered
      an_event(Assignments::ProjectRegistered).with_data(project_data)
    end

    def project_estimated
      an_event(Assignments::ProjectEstimated).with_data(estimate_data)
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

    def project_uuid
      'cfaf0e8e-e40e-4068-be27-dd42a30d9b0d'
    end

    def project_name
      'awesome_project'
    end

    def project_estimation
      40
    end

    def event_store
      Rails.configuration.event_store
    end
  end
end
