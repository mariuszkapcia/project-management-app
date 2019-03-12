require_dependency 'project_management'

require_relative '../support/test_attributes'

module ProjectManagement
  RSpec.describe 'AssignDeveloperWorkingHours command' do
    include TestAttributes

    cover 'ProjectManagement::AssignDeveloperWorkingHours*'

    specify 'should validate presence of project_uuid' do
      cmd = ProjectManagement::AssignDeveloperWorkingHours.new(
        project_uuid:   nil,
        developer_uuid: developer_ignacy[:uuid],
        hours_per_week: developer_ignacy[:fullname]
      )

      expect { cmd.verify! }.to raise_error(Command::ValidationError)
    end

    specify 'should validate format of project_uuid' do
      cmd = ProjectManagement::AssignDeveloperWorkingHours.new(
        project_uuid:   'wrong_uuid_format',
        developer_uuid: developer_ignacy[:uuid],
        hours_per_week: developer_ignacy[:fullname]
      )

      expect { cmd.verify! }.to raise_error(Command::ValidationError)
    end

    specify 'should validate presence of developer_uuid' do
      cmd = ProjectManagement::AssignDeveloperWorkingHours.new(
        project_uuid:   project_topsecretdddproject[:uuid],
        developer_uuid: nil,
        hours_per_week: developer_ignacy[:fullname]
      )

      expect { cmd.verify! }.to raise_error(Command::ValidationError)
    end

    specify 'should validate format of developer_uuid' do
      cmd = ProjectManagement::AssignDeveloperWorkingHours.new(
        project_uuid:   project_topsecretdddproject[:uuid],
        developer_uuid: 'wrong_uuid_format',
        hours_per_week: developer_ignacy[:fullname]
      )

      expect { cmd.verify! }.to raise_error(Command::ValidationError)
    end

    specify 'should validate presence of hours_per_week' do
      cmd = ProjectManagement::AssignDeveloperWorkingHours.new(
        project_uuid:   project_topsecretdddproject[:uuid],
        developer_uuid: developer_ignacy[:uuid],
        hours_per_week: nil
      )

      expect { cmd.verify! }.to raise_error(Command::ValidationError)
    end
  end
end
