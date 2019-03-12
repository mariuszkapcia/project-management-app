require_dependency 'project_management'

require_relative '../support/test_attributes'

module ProjectManagement
  RSpec.describe 'AssignDeveloperToProject command' do
    include TestAttributes

    cover 'ProjectManagement::AssignDeveloperToProject*'

    specify 'should validate presence of project_uuid' do
      cmd = ProjectManagement::AssignDeveloperToProject.new(
        project_uuid:       nil,
        developer_uuid:     developer_ignacy[:uuid],
        developer_fullname: developer_ignacy[:fullname]
      )

      expect { cmd.verify! }.to raise_error(Command::ValidationError)
    end

    specify 'should validate format of project_uuid' do
      cmd = ProjectManagement::AssignDeveloperToProject.new(
        project_uuid:       'wrong_uuid_format',
        developer_uuid:     developer_ignacy[:uuid],
        developer_fullname: developer_ignacy[:fullname]
      )

      expect { cmd.verify! }.to raise_error(Command::ValidationError)
    end

    specify 'should validate presence of developer_uuid' do
      cmd = ProjectManagement::AssignDeveloperToProject.new(
        project_uuid:       project_topsecretdddproject[:uuid],
        developer_uuid:     nil,
        developer_fullname: developer_ignacy[:fullname]
      )

      expect { cmd.verify! }.to raise_error(Command::ValidationError)
    end

    specify 'should validate format of developer_uuid' do
      cmd = ProjectManagement::AssignDeveloperToProject.new(
        project_uuid:       project_topsecretdddproject[:uuid],
        developer_uuid:     'wrong_uuid_format',
        developer_fullname: developer_ignacy[:fullname]
      )

      expect { cmd.verify! }.to raise_error(Command::ValidationError)
    end

    specify 'should validate presence of developer_fullname' do
      cmd = ProjectManagement::AssignDeveloperToProject.new(
        project_uuid:       project_topsecretdddproject[:uuid],
        developer_uuid:     developer_ignacy[:uuid],
        developer_fullname: nil
      )

      expect { cmd.verify! }.to raise_error(Command::ValidationError)
    end
  end
end
