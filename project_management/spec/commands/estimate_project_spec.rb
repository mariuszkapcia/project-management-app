require_dependency 'project_management'

require_relative '../support/test_attributes'

module ProjectManagement
  RSpec.describe 'EstimateProject command' do
    include TestAttributes

    specify 'should validate presence of uuid' do
      cmd = ProjectManagement::EstimateProject.new(
        uuid:  nil,
        hours: project_topsecretdddproject[:estimation]
      )

      expect { cmd.verify! }.to raise_error(Command::ValidationError)
    end

    specify 'should validate format of uuid' do
      cmd = ProjectManagement::EstimateProject.new(
        uuid:  'wrong_uuid_format',
        hours: project_topsecretdddproject[:estimation]
      )

      expect { cmd.verify! }.to raise_error(Command::ValidationError)
    end

    specify 'should validate presence of hours' do
      cmd = ProjectManagement::EstimateProject.new(
        uuid:  project_topsecretdddproject[:uuid],
        hours: nil
      )

      expect { cmd.verify! }.to raise_error(Command::ValidationError)
    end
  end
end
