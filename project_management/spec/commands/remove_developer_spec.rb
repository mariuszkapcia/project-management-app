require_dependency 'project_management'

require_relative '../support/test_attributes'

module ProjectManagement
  RSpec.describe 'RemoveDeveloper command' do
    include TestAttributes

    specify 'should validate presence of developer_uuid' do
      cmd = ProjectManagement::RemoveDeveloper.new(
        developer_uuid: nil
      )

      expect { cmd.verify! }.to raise_error(Command::ValidationError)
    end

    specify 'should validate format of developer_uuid' do
      cmd = ProjectManagement::RemoveDeveloper.new(
        developer_uuid: 'wrong_uuid_format'
      )

      expect { cmd.verify! }.to raise_error(Command::ValidationError)
    end
  end
end
