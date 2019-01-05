module Notifications
  class ProjectKickedOffHandler
    def call(event)
      project = @project_list_read_model.retrieve.find(event.data[:project_uuid])

      Notifications::ProjectKickoffMailer
        .new(event_store: @event_store)
        .deliver(event.data[:project_uuid], project[:name])
    end

    private

    def initialize(event_store:)
      @event_store             = event_store
      @project_list_read_model = ProjectList::Retriever.new(event_store: event_store)
    end
  end
end
