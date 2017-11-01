require_dependency 'assignments'

module Assignments
  RSpec.describe 'Developer services' do
    specify 'register a new developer' do
      RegisterDeveloperService
        .new(event_store: event_store)
        .call(RegisterDeveloper.new(
          uuid: developer_uuid,
          name: developer_name
        ))

      expect(event_store).to(have_published(developer_registered))
    end

    private

    def developer_registered
      an_event(Assignments::DeveloperRegistered).with_data(developer_data)
    end

    def developer_data
      {
        uuid: developer_uuid,
        name: developer_name
      }
    end

    def developer_uuid
      'cb69ec8a-9069-4679-8048-34344f220801'
    end

    def developer_name
      'Ignacy'
    end

    def event_store
      Rails.configuration.event_store
    end
  end
end
