require_dependency 'ui'

module UI
  RSpec.describe 'Projects read model' do
    specify 'creates project' do
      read_model.call(project_registered)
      expect(read_model.all.size).to eq(1)
      assert_project_correct
    end

    private

    def assert_project_correct
      expect(first_project.uuid).to eq(project_uuid)
      expect(first_project.name).to eq(project_name)
    end

    def project_registered
      ProjectManagement::ProjectRegistered.new(data: {
        uuid: project_uuid,
        name: project_name
      })
    end

    def project_uuid
      'ab6e9c30-2b1c-474d-824f-7b8f816ced99'
    end

    def project_name
      'awesome_project'
    end

    def read_model
      @project_list_read_model ||= UI::ProjectListReadModel.new
    end

    def first_project
      read_model.all.first
    end
  end
end
