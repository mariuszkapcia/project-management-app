require_dependency 'assignments'

module Assignments
  RSpec.describe Project do
    specify 'register new project' do
      project = Assignments::Project.new(project_uuid)
      project.register(project_name)

      expect(project).to(have_applied(project_registered))
    end

    private

    def project_registered
      an_event(Assignments::ProjectRegistered).with_data(project_data)
    end

    def project_data
      {
        uuid: project_uuid,
        name: project_name
      }
    end

    def project_uuid
      'ab6e9c30-2b1c-474d-824f-7b8f816ced99'
    end

    def project_name
      'awesome_project'
    end
  end
end
