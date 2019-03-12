require_dependency 'project_management'

require_relative '../support/test_attributes'

module ProjectManagement
  RSpec.describe 'AssignDeadline command' do
    include TestAttributes

    cover 'ProjectManagement::AssignDeadline*'

    specify 'should validate presence of project_uuid' do
      cmd = ProjectManagement::AssignDeadline.new(
        project_uuid: nil,
        deadline:     project_topsecretdddproject[:estimation]
      )

      expect { cmd.verify! }.to raise_error(Command::ValidationError)
    end

    specify 'should validate format of project_uuid' do
      cmd = ProjectManagement::AssignDeadline.new(
        project_uuid: 'wrong_uuid_format',
        deadline:     project_topsecretdddproject[:estimation]
      )

      expect { cmd.verify! }.to raise_error(Command::ValidationError)
    end

    specify 'should validate presence of deadline' do
      cmd = ProjectManagement::AssignDeadline.new(
        project_uuid: project_topsecretdddproject[:uuid],
        deadline:     nil
      )

      expect { cmd.verify! }.to raise_error(Command::ValidationError)
    end
  end
end
