require_dependency 'project_management'

module ProjectManagement
  RSpec.describe 'EstimateProject command' do

    specify 'should validate presence of uuid' do
      cmd = ProjectManagement::EstimateProject.new(
        uuid: nil,
        hours: project_hours
      )

      expect { cmd.verify! }.to raise_error(Command::ValidationError)
    end

    specify 'should validate format of uuid' do
      cmd = ProjectManagement::EstimateProject.new(
        uuid: 'wrong_uuid_format',
        hours: project_hours
      )

      expect { cmd.verify! }.to raise_error(Command::ValidationError)
    end

    specify 'should validate presence of hours' do
      cmd = ProjectManagement::EstimateProject.new(
        uuid: project_uuid,
        hours: nil
      )

      expect { cmd.verify! }.to raise_error(Command::ValidationError)
    end

    private

    def project_uuid
      'ab6e9c30-2b1c-474d-824f-7b8f816ced99'
    end

    def project_hours
      40
    end
  end
end
