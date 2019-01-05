module Notifications
  class ProjectKickedOffHandler
    def call(event)
      Notifications::ProjectKickoffMailer
        .new(event_store: event_store)
        .deliver(event.data[:project_uuid], 'project_name_placeholder')
    end

    private

    def event_store
      Rails.configuration.event_store
    end
  end
end
