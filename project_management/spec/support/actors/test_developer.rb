module ProjectManagement
  class TestDeveloper
    def register(developer)
      @uuid = developer[:uuid]

      @command_handler
        .new(event_store: @event_store, command_store: @command_store)
        .call(
          ProjectManagement::RegisterDeveloper.new(
            developer_uuid: developer[:uuid],
            fullname:       developer[:fullname],
            email:          developer[:email]
          )
        )
    end

    private

    def initialize(event_store:, command_store:)
      @uuid            = nil
      @event_store     = event_store
      @command_store   = command_store
      @command_handler = ProjectManagement::DevelopersCommandHandler
    end
  end
end
