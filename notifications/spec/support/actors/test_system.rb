module Notifications
  class TestSystem
    def send_project_kickoff_email(project)
      @command_handler
        .new(event_store: @event_store)
        .call(
          Notifications::SendProjectKickoffEmail.new(
            project_uuid: project[:uuid],
            project_name: project[:name]
          )
        )
    end

    private

    def initialize(event_store: Rails.configuration.event_store)
      @event_store     = event_store
      @command_handler = Notifications::NotificationsCommandHandler
    end
  end
end
