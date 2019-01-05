module Notifications
  class ProjectList::Retriever
    def retrieve
      @state = reply_state
      self
    end

    def projects
      @state.projects
    end

    def find(project_uuid)
      @state.projects.find { |project| project[:uuid] == project_uuid }
    end

    private

    def initialize(event_store:)
      @event_store = event_store
    end

    def reply_state
      all_events_in(stream_name).each_with_object(ProjectList::State.new) do |event, state|
        state.reply(event)
      end
    end

    def all_events_in(stream_name)
      @event_store.read.stream(stream_name).each.to_a
    end

    def stream_name
      'Notifications::ProjectListReadModel'
    end
  end
end
