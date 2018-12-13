require_dependency 'project_management'

module ProjectManagement
  RSpec.describe 'Developer aggregate' do
    specify 'register a new developer' do
      developer = ProjectManagement::Developer.new(developer_uuid)
      developer.register(developer_fullname, developer_email)

      expect(developer).to(have_applied(developer_registered))
    end

    private

    def developer_registered
      an_event(ProjectManagement::DeveloperRegistered).with_data(developer_data).strict
    end

    def developer_data
      {
        uuid:     developer_uuid,
        fullname: developer_fullname,
        email:    developer_email
      }
    end

    def developer_uuid
      '62147dcd-d315-4120-b7ec-f6b00d10c223'
    end

    def developer_fullname
      'Ignacy Ignacy'
    end

    def developer_email
      'ignacy@gmail.com'
    end
  end
end
