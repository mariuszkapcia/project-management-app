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
        'ProjectManagement::DeveloperRegistered' => :apply_developer_registered,
        'ProjectManagement::DeveloperRemoved'    => :apply_developer_removed
      }.fetch(event_class.to_s)
    end

    def apply_developer_registered(event)
      @developers << {
        uuid:  event.data[:developer_uuid],
        email: event.data[:email]
      }
    end

    def apply_developer_removed(event)
      developer         = @developers.find { |developer| developer[:uuid].eql?(event.data[:developer_uuid]) }
      developer[:email] = ''
    end
  end
end
