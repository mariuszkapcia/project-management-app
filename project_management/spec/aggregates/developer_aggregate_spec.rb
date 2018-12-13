require_dependency 'project_management'

require_relative '../support/test_attributes'

module ProjectManagement
  RSpec.describe 'Developer aggregate' do
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

    private

    def developer_registered
      an_event(ProjectManagement::DeveloperRegistered).with_data(developer_registered_data).strict
    end

    def developer_registered_data
      {
        uuid:     developer_ignacy[:uuid],
        fullname: developer_ignacy[:fullname],
        email:    developer_ignacy[:email]
      }
    end
  end
end
