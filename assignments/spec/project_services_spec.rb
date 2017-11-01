require 'rails_helper'
require_dependency 'assignments'

module Assignments
  RSpec.describe 'Project services' do
    specify do
      Assignments::RegisterProjectService
        .new(event_store: event_store)
        .call(Assignments::RegisterProject.new(
          uuid: 'cfaf0e8e-e40e-4068-be27-dd42a30d9b0d',
          name: 'awesome_project'
        ))

        expect(event_store).to(have_published(project_registered))
    end

    private

    def project_registered
      an_event(Assignments::ProjectRegistered).with_data(project_data)
    end

    def project_data
      {
        uuid: 'cfaf0e8e-e40e-4068-be27-dd42a30d9b0d',
        name: 'awesome_project'
      }
    end

    def event_store
      Rails.configuration.event_store
    end
  end
end
