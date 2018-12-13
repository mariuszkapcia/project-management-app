module ProjectManagement
  class DeveloperList::State
    def reply(event)
      handler = map_event_to_handler(event.class)
      send(handler, event)
    end

    def developers
      @developers
    end

    private

    def initialize
      @developers = []
    end

    def map_event_to_handler(event_class)
      {
        'ProjectManagement::DeveloperRegistered' => :apply_developer_registered
      }.fetch(event_class.to_s)
    end

    def apply_developer_registered(event)
      @developers << {
        uuid:     event.data[:uuid],
        fullname: event.data[:fullname]
      }
    end
  end
end
