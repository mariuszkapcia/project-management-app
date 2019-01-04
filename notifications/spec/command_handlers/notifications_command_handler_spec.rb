require_dependency 'notifications'

require_relative '../support/test_attributes'

module Notifications
  RSpec.describe 'DevelopersCommandHandler' do
    include TestAttributes

    specify 'send project kickoff email' do
      skip('implement')
    end

    private

    def event_store
      RailsEventStore::Client.new.tap do |es|
        ConfigureNotificationsBoundedContext.new(event_store: es).call
      end
    end
  end
end
