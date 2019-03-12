require_dependency 'project_management'

require_relative '../support/test_attributes'

module ProjectManagement
  RSpec.describe 'EstimateProject command' do
    include TestAttributes

    specify 'should validate presence of project_uuid' do
      cmd = ProjectManagement::EstimateProject.new(
        project_uuid: nil,
        hours:        project_topsecretdddproject[:estimation]
      )

      expect { cmd.verify! }.to raise_error(Command::ValidationError)
    end

    specify 'should validate format of project_uuid' do
      cmd = ProjectManagement::EstimateProject.new(
        project_uuid: 'wrong_uuid_format',
        hours:        project_topsecretdddproject[:estimation]
      )

      expect { cmd.verify! }.to raise_error(Command::ValidationError)
    end

    specify 'should validate presence of hours' do
      cmd = ProjectManagement::EstimateProject.new(
        project_uuid: project_topsecretdddproject[:uuid],
        hours:        nil
      )

      expect { cmd.verify! }.to raise_error(Command::ValidationError)
    end
  end
end
