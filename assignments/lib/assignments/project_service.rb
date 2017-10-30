module Assignments
  class ProjectService
    def initialize(event_store)
      @event_store = event_store
    end

    def call(_command)
    end
  end
end
