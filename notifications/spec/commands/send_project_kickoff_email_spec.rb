require_dependency 'notifications'

require_relative '../support/test_attributes'

module Notifications
  RSpec.describe 'SendProjectKickoffEmail command' do
    include TestAttributes

    specify 'should validate presence of project_uuid' do
      cmd = Notifications::SendProjectKickoffEmail.new(
        project_uuid: nil,
        project_name: project_topsecretdddproject[:name]
      )

      expect { cmd.verify! }.to raise_error(Command::ValidationError)
    end

    specify 'should validate format of project_uuid' do
      cmd = Notifications::SendProjectKickoffEmail.new(
        project_uuid: 'wrong_uuid_format',
        project_name: project_topsecretdddproject[:name]
      )

      expect { cmd.verify! }.to raise_error(Command::ValidationError)
    end

    specify 'should validate presence of project_name' do
      cmd = Notifications::SendProjectKickoffEmail.new(
        project_uuid: project_topsecretdddproject[:uuid],
        project_name: nil
      )

      expect { cmd.verify! }.to raise_error(Command::ValidationError)
    end
  end
end
