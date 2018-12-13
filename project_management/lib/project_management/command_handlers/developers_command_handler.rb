module ProjectManagement
  class DevelopersCommandHandler
    def initialize(event_store:)
      @event_store = event_store
      @command_bus = Arkency::CommandBus.new
      {
        ProjectManagement::RegisterDeveloper => method(:register)
      }.map{ |klass, handler| @command_bus.register(klass, handler) }
    end

    def call(*commands)
      commands.each do |command|
        @command_bus.call(command)
      end
    end

    private

    def register(cmd)
      cmd.verify!

      ActiveRecord::Base.transaction do
        with_developer(cmd.uuid) do |developer|
          developer.register(cmd.fullname, cmd.email)
        end
      end
    end

    def with_developer(uuid)
      ProjectManagement::Developer.new(uuid).tap do |developer|
        load_developer(uuid, developer)
        yield developer
        store_developer(developer)
      end
    end

    def load_developer(developer_uuid, developer)
      developer.load(stream_name(developer_uuid), event_store: @event_store)
    end

    def store_developer(developer)
      developer.store(event_store: @event_store)
    end

    def stream_name(developer_uuid)
      "ProjectManagement::Developer$#{developer_uuid}"
    end
  end
end
