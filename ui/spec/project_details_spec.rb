require_dependency 'ui'

require_relative './support/test_attributes'

module UI
  RSpec.describe 'Project details read model' do
    include TestAttributes

    specify 'creates project' do
      read_model.call(project_registered)
      expect(read_model.all.size).to eq(1)
      assert_project_correct
    end

    specify 'estimate the project' do
      read_model.call(project_registered)
      read_model.call(project_estimated)
      expect(read_model.all.size).to eq(1)
      assert_project_with_estimation_correct
    end

    specify 'assign developer to the project' do
      read_model.call(project_registered)
      read_model.call(developer_assigned)
      read_model.call(developer_working_hours_for_project_assigned)
      expect(read_model.all.size).to eq(1)
      assert_project_with_developers_correct
    end

    private

    def assert_project_correct
      expect(first_project.uuid).to eq(project_topsecretdddproject[:uuid])
      expect(first_project.name).to eq(project_topsecretdddproject[:name])
      expect(first_project.estimation_in_hours).to eq(nil)
      expect(first_project.developers).to eq([])
    end

    def assert_project_with_estimation_correct
      expect(first_project.uuid).to eq(project_topsecretdddproject[:uuid])
      expect(first_project.name).to eq(project_topsecretdddproject[:name])
      expect(first_project.estimation_in_hours).to eq(project_topsecretdddproject[:estimation])
      expect(first_project.developers).to eq([])
    end

    def assert_project_with_developers_correct
      expect(first_project.uuid).to eq(project_topsecretdddproject[:uuid])
      expect(first_project.name).to eq(project_topsecretdddproject[:name])
      expect(first_project.estimation_in_hours).to eq(nil)
      expect(first_project.developers).to eq(
        [
          { 'uuid'           => developer_ignacy[:uuid],
            'fullname'       => developer_ignacy[:fullname],
            'hours_per_week' => developer_ignacy[:hours_per_week]
          }
        ]
      )
    end

    def project_registered
      ProjectManagement::ProjectRegistered.new(data: {
        project_uuid: project_topsecretdddproject[:uuid],
        name:         project_topsecretdddproject[:name]
      })
    end

    def project_estimated
      ProjectManagement::ProjectEstimatedV2.new(data: {
        project_uuid: project_topsecretdddproject[:uuid],
        hours:        project_topsecretdddproject[:estimation]
      })
    end

    def developer_assigned
      ProjectManagement::DeveloperAssignedToProject.new(data: {
        project_uuid:       project_topsecretdddproject[:uuid],
        developer_uuid:     developer_ignacy[:uuid],
        developer_fullname: developer_ignacy[:fullname]
      })
    end

    def developer_working_hours_for_project_assigned
      ProjectManagement::DeveloperWorkingHoursForProjectAssigned.new(data: {
        project_uuid:   project_topsecretdddproject[:uuid],
        developer_uuid: developer_ignacy[:uuid],
        hours_per_week: developer_ignacy[:hours_per_week]
      })
    end

    def read_model
      @project_details_read_model ||= UI::ProjectDetailsReadModel.new
    end

    def first_project
      read_model.all.first
    end
  end
end
