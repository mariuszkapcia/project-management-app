require_dependency 'project_management'

require_relative '../support/test_attributes'
require_relative '../support/test_actors'
require_relative '../support/fakes'

module ProjectManagement
  RSpec.describe 'DevelopersCommandHandler' do
    include TestAttributes
    include TestActors
    include Fakes

    specify 'register a new developer' do
      developer = instance_of_developer(event_store: event_store, command_store: command_store)
      developer.register(developer_ignacy)

      expect(event_store).to(have_published(developer_registered))
    end

    specify 'cannot register developer without uniq email address' do
      developer = instance_of_developer(event_store: event_store, command_store: command_store)
      developer.register(developer_ignacy)

      expect do
        developer.register(developer_ignacy)
      end.to raise_error(ProjectManagement::Developer::EmailAddressNotUniq)
    end

    private

    def developer_registered
      an_event(ProjectManagement::DeveloperRegistered).with_data(developer_registered_data).strict
    end

    def developer_registered_data
      {
        developer_uuid: developer_ignacy[:uuid],
        fullname:       developer_ignacy[:fullname],
        email:          developer_ignacy[:email]
      }
    end

    def command_store
      @command_store ||= Fakes::CommandStore.new
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
