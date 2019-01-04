module Notifications
  class ProjectKickoffMailer
    # NOTE: I don't want to send a real email here so I publish domain event and display information on the UI.
    def deliver(project_uuid, project_name)
      event_store.publish(
        Notifications::ProjectKickoffEmailSent.strict(data: {
          project_uuid: project_uuid,
          project_name: project_name
        }),
        stream_name: stream_name
      )
    end

    private

    def initialize(event_store:)
      @event_store = event_store
    end

    def stream_name
      'ProjectKickoffMailer'
    end
  end
end
