require_dependency 'project_management'

require_relative '../support/test_attributes'

module ProjectManagement
  RSpec.describe 'KickOffProject command' do
    include TestAttributes

    specify 'should validate presence of project_uuid' do
      cmd = ProjectManagement::KickOffProject.new(
        project_uuid: nil
      )

      expect { cmd.verify! }.to raise_error(Command::ValidationError)
    end

    specify 'should validate format of project_uuid' do
      cmd = ProjectManagement::KickOffProject.new(
        project_uuid: 'wrong_uuid_format'
      )

      expect { cmd.verify! }.to raise_error(Command::ValidationError)
    end
  end
end
