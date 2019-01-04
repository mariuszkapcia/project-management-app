require_dependency 'notifications'

require_relative '../support/test_actors'
require_relative '../support/test_attributes'

module Notifications
  RSpec.describe 'DevelopersCommandHandler' do
    include TestActors
    include TestAttributes

    specify 'send project kickoff email' do
      system = instance_of_system(event_store: event_store)
      system.send_project_kickoff_email(project_topsecretdddproject)

      expect(event_store).to(have_published(project_kickoff_email_sent))
    end

    private

    def project_kickoff_email_sent
      an_event(Notifications::ProjectKickoffEmailSent).with_data(project_kickoff_email_sent_data).strict
    end

    def project_kickoff_email_sent_data
      {
        project_uuid: project_topsecretdddproject[:uuid],
        project_name: project_topsecretdddproject[:name]
      }
    end

    def event_store
      RailsEventStore::Client.new.tap do |es|
        ConfigureNotificationsBoundedContext.new(event_store: es).call
      end
    end
  end
end
