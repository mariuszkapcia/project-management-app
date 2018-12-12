require_dependency 'project_management'

module ProjectManagement
  RSpec.describe 'DevelopersService' do
    specify 'register a new developer' do
      ProjectManagement::DevelopersCommandHandler
        .new(event_store: event_store)
        .call(
          ProjectManagement::RegisterDeveloper.new(
            uuid:     developer_uuid,
            fullname: developer_fullname,
            email:    developer_email)
        )

      expect(event_store).to(have_published(developer_registered))
    end

    private

    def developer_registered
      an_event(ProjectManagement::DeveloperRegistered).with_data(developer_data)
    end

    def developer_data
      {
        uuid:     developer_uuid,
        fullname: developer_fullname
      }
    end

    def developer_uuid
      'cb69ec8a-9069-4679-8048-34344f220801'
    end

    def developer_fullname
      'Ignacy Ignacy'
    end

    def developer_email
      'ignacy@onet.pl'
    end

    def event_store
      Rails.configuration.event_store
    end
  end
end
