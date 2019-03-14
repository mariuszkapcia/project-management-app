require_dependency 'project_management'

require_relative '../support/test_attributes'

module ProjectManagement
  RSpec.describe 'ProjectManagement::Developer' do
    include TestAttributes

    specify 'register a new developer' do
      developer = ProjectManagement::Developer.new(developer_ignacy[:uuid])
      developer.register(developer_ignacy[:fullname], developer_ignacy[:email])

      expect(developer).to(have_applied(developer_registered))
    end

    specify 'developer cannot be registered twice' do
      developer = ProjectManagement::Developer.new(developer_ignacy[:uuid])
      developer.register(developer_ignacy[:fullname], developer_ignacy[:email])

      expect do
        developer.register(developer_ignacy[:fullname], developer_ignacy[:email])
      end.to raise_error(ProjectManagement::Developer::HasBeenAlreadyRegistered)
    end

    specify 'remove developer' do
      developer = ProjectManagement::Developer.new(developer_ignacy[:uuid])
      developer.register(developer_ignacy[:fullname], developer_ignacy[:email])
      developer.remove

      expect(developer).to(have_applied(developer_removed))
    end

    specify 'developer cannot be removed twice' do
      developer = ProjectManagement::Developer.new(developer_ignacy[:uuid])
      developer.register(developer_ignacy[:fullname], developer_ignacy[:email])
      developer.remove
      developer.remove

      expect(developer).to(have_applied(developer_removed).exactly(1).times)
    end

    private

    def developer_registered
      an_event(ProjectManagement::DeveloperRegistered).with_data(developer_registered_data).strict
    end

    def developer_removed
      an_event(ProjectManagement::DeveloperRemoved).with_data(developer_removed_data).strict
    end

    def developer_registered_data
      {
        developer_uuid: developer_ignacy[:uuid],
        fullname:       developer_ignacy[:fullname],
        email:          developer_ignacy[:email]
      }
    end

    def developer_removed_data
      {
        developer_uuid: developer_ignacy[:uuid]
      }
    end
  end
end
