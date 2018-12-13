require_dependency 'project_management'

module ProjectManagement
  RSpec.describe 'RegisterDeveloper command' do

    specify 'should validate presence of uuid' do
      cmd = ProjectManagement::RegisterDeveloper.new(
        uuid:     nil,
        fullname: developer_fullname,
        email:    developer_email
      )

      expect { cmd.verify! }.to raise_error(Command::ValidationError)
    end

    specify 'should validate format of uuid' do
      cmd = ProjectManagement::RegisterDeveloper.new(
        uuid:     'wrong_uuid_format',
        fullname: developer_fullname,
        email:    developer_email
      )

      expect { cmd.verify! }.to raise_error(Command::ValidationError)
    end

    specify 'should validate presence of fullname' do
      cmd = ProjectManagement::RegisterDeveloper.new(
        uuid:     developer_uuid,
        fullname: nil,
        email:    developer_email
      )

      expect { cmd.verify! }.to raise_error(Command::ValidationError)
    end

    specify 'should validate presence of email' do
      cmd = ProjectManagement::RegisterDeveloper.new(
        uuid:     developer_uuid,
        fullname: developer_fullname,
        email:    nil
      )

      expect { cmd.verify! }.to raise_error(Command::ValidationError)
    end

    private

    def developer_uuid
      '99912b93-ba22-48da-ac83-f49a74db22e4'
    end

    def developer_fullname
      'Ignacy Ignacy'
    end

    def developer_email
      'ignacy@gmail.com'
    end
  end
end
