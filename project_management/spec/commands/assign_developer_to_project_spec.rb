require_dependency 'project_management'

module ProjectManagement
  RSpec.describe 'AssignDeveloperToProject command' do

    specify 'should validate presence of project_uuid' do
      cmd = ProjectManagement::AssignDeveloperToProject.new(
        project_uuid:       nil,
        developer_uuid:     developer_uuid,
        developer_fullname: developer_fullname
      )

      expect { cmd.verify! }.to raise_error(Command::ValidationError)
    end

    specify 'should validate format of project_uuid' do
      cmd = ProjectManagement::AssignDeveloperToProject.new(
        project_uuid:       'wrong_uuid_format',
        developer_uuid:     developer_uuid,
        developer_fullname: developer_fullname
      )

      expect { cmd.verify! }.to raise_error(Command::ValidationError)
    end

    specify 'should validate presence of developer_uuid' do
      cmd = ProjectManagement::AssignDeveloperToProject.new(
        project_uuid:       project_uuid,
        developer_uuid:     nil,
        developer_fullname: developer_fullname
      )

      expect { cmd.verify! }.to raise_error(Command::ValidationError)
    end

    specify 'should validate format of developer_uuid' do
      cmd = ProjectManagement::AssignDeveloperToProject.new(
        project_uuid:       project_uuid,
        developer_uuid:     'wrong_uuid_format',
        developer_fullname: developer_fullname
      )

      expect { cmd.verify! }.to raise_error(Command::ValidationError)
    end

    specify 'should validate presence of developer_fullname' do
      cmd = ProjectManagement::AssignDeveloperToProject.new(
        project_uuid:       project_uuid,
        developer_uuid:     developer_uuid,
        developer_fullname: nil
      )

      expect { cmd.verify! }.to raise_error(Command::ValidationError)
    end

    private

    def project_uuid
      'ab6e9c30-2b1c-474d-824f-7b8f816ced99'
    end

    def developer_uuid
      '99912b93-ba22-48da-ac83-f49a74db22e4'
    end

    def developer_fullname
      'Ignacy Ignacy'
    end
  end
end
