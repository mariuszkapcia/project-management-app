class DevelopersService
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

  def register(command)
    with_developer(command.uuid) do |developer|
      developer.register(command.fullname, command.email)
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
    "Developer$#{developer_uuid}"
  end
end
