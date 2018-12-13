require_dependency 'project_management'

module ProjectManagement
  RSpec.describe 'RegisterProject command' do

    specify 'should validate presence of uuid' do
      cmd = ProjectManagement::RegisterProject.new(
        uuid: nil,
        name: project_name
      )

      expect { cmd.verify! }.to raise_error(Command::ValidationError)
    end

    specify 'should validate format of uuid' do
      cmd = ProjectManagement::RegisterProject.new(
        uuid: 'wrong_uuid_format',
        name: project_name
      )

      expect { cmd.verify! }.to raise_error(Command::ValidationError)
    end

    specify 'should validate presence of name' do
      cmd = ProjectManagement::RegisterProject.new(
        uuid: project_uuid,
        name: nil
      )

      expect { cmd.verify! }.to raise_error(Command::ValidationError)
    end

    private

    def project_uuid
      'ab6e9c30-2b1c-474d-824f-7b8f816ced99'
    end

    def project_name
      '#TopSecretDDDProject'
    end
  end
end
