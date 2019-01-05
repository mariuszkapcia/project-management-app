module Notifications
  class ProjectList::State
    def reply(event)
      handler = map_event_to_handler(event.class)
      send(handler, event)
    end

    def projects
      @projects
    end

    private

    def initialize
      @projects = []
    end

    def map_event_to_handler(event_class)
      {
        'ProjectManagement::ProjectRegistered' => :apply_project_registered
      }.fetch(event_class.to_s)
    end

    def apply_project_registered(event)
      @projects << {
        uuid: event.data[:project_uuid],
        name: event.data[:name]
      }
    end
  end
end
