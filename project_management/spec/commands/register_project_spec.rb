require_dependency 'project_management'

require_relative '../support/test_attributes'

module ProjectManagement
  RSpec.describe 'RegisterProject command' do
    include TestAttributes

    cover 'ProjectManagement::RegisterProject*'

    specify 'should validate presence of project_uuid' do
      cmd = ProjectManagement::RegisterProject.new(
        project_uuid: nil,
        name:         project_topsecretdddproject[:name]
      )

      expect { cmd.verify! }.to raise_error(Command::ValidationError)
    end

    specify 'should validate format of project_uuid' do
      cmd = ProjectManagement::RegisterProject.new(
        project_uuid: 'wrong_uuid_format',
        name:         project_topsecretdddproject[:name]
      )

      expect { cmd.verify! }.to raise_error(Command::ValidationError)
    end

    specify 'should validate presence of name' do
      cmd = ProjectManagement::RegisterProject.new(
        project_uuid: project_topsecretdddproject[:uuid],
        name:         nil
      )

      expect { cmd.verify! }.to raise_error(Command::ValidationError)
    end
  end
end
