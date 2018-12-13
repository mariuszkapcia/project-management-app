require_dependency 'project_management'

require_relative '../support/test_attributes'
require_relative '../support/test_actors'

module ProjectManagement
  RSpec.describe 'DevelopersCommandHandler' do
    include TestAttributes
    include TestActors

    specify 'register a new developer' do
      developer = instance_of_developer(event_store: event_store)
      developer.register(developer_ignacy)

      expect(event_store).to(have_published(developer_registered))
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

    def event_store
      RailsEventStore::Client.new.tap do |es|
        ConfigureProjectManagementBoundedContext.new(event_store: es).call
      end
    end
  end
end
