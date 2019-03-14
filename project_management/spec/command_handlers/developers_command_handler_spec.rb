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

    specify 'cannot register developer without uniq email address' do
      developer = instance_of_developer(event_store: event_store)
      developer.register(developer_ignacy)

      expect do
        developer.register(developer_ignacy)
      end.to raise_error(ProjectManagement::Developer::EmailAddressNotUniq)
    end

    specify 'remove developer' do
      developer = instance_of_developer(event_store: event_store)
      developer.register(developer_ignacy)
      developer.remove

      expect(event_store).to(have_published(developer_removed))
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

    def event_store
      @event_store ||= begin
        RailsEventStore::Client.new.tap do |es|
          ConfigureProjectManagementBoundedContext.new(event_store: es).call
        end
      end
    end
  end
end
