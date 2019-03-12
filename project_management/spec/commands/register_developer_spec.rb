require_dependency 'project_management'

require_relative '../support/test_attributes'

module ProjectManagement
  RSpec.describe 'RegisterDeveloper command' do
    include TestAttributes

    specify 'should validate presence of developer_uuid' do
      cmd = ProjectManagement::RegisterDeveloper.new(
        developer_uuid: nil,
        fullname:       developer_ignacy[:fullname],
        email:          developer_ignacy[:email]
      )

      expect { cmd.verify! }.to raise_error(Command::ValidationError)
    end

    specify 'should validate format of developer_uuid' do
      cmd = ProjectManagement::RegisterDeveloper.new(
        developer_uuid: 'wrong_uuid_format',
        fullname:       developer_ignacy[:fullname],
        email:          developer_ignacy[:email]
      )

      expect { cmd.verify! }.to raise_error(Command::ValidationError)
    end

    specify 'should validate presence of fullname' do
      cmd = ProjectManagement::RegisterDeveloper.new(
        developer_uuid: developer_ignacy[:uuid],
        fullname:       nil,
        email:          developer_ignacy[:email]
      )

      expect { cmd.verify! }.to raise_error(Command::ValidationError)
    end

    specify 'should validate presence of email' do
      cmd = ProjectManagement::RegisterDeveloper.new(
        developer_uuid: developer_ignacy[:uuid],
        fullname:       developer_ignacy[:fullname],
        email:          nil
      )

      expect { cmd.verify! }.to raise_error(Command::ValidationError)
    end

    specify 'should validate format of email' do
      cmd = ProjectManagement::RegisterDeveloper.new(
        developer_uuid: developer_ignacy[:uuid],
        fullname:       developer_ignacy[:fullname],
        email:          'wrong_email_format'
      )

      expect { cmd.verify! }.to raise_error(Command::ValidationError)
    end
  end
end
