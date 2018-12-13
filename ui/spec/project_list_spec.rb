require_dependency 'ui'

require_relative './support/test_attributes'

module UI
  RSpec.describe 'Projects read model' do
    include TestAttributes

    specify 'creates project' do
      read_model.call(project_registered)
      expect(read_model.all.size).to eq(1)
      assert_project_correct
    end

    private

    def assert_project_correct
      expect(first_project.uuid).to eq(project_topsecretdddproject[:uuid])
      expect(first_project.name).to eq(project_topsecretdddproject[:name])
    end

    def project_registered
      ProjectManagement::ProjectRegistered.new(data: {
        uuid: project_topsecretdddproject[:uuid],
        name: project_topsecretdddproject[:name]
      })
    end

    def read_model
      @project_list_read_model ||= UI::ProjectListReadModel.new
    end

    def first_project
      read_model.all.first
    end
  end
end
