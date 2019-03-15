module ProjectManagement
  class DevelopersCommandHandler
    def initialize(event_store:, command_store:)
      @event_store               = event_store
      @command_store             = command_store
      @developer_list_read_model = DeveloperList::Retriever.new(event_store: @event_store)
      @command_bus               = Arkency::CommandBus.new
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

      raise Developer::EmailAddressNotUniq if @developer_list_read_model.retrieve.email_taken?(cmd.email)

      ActiveRecord::Base.transaction do
        with_developer(cmd.developer_uuid) do |developer|
          developer.register(cmd.fullname, cmd.email)
        end

        # NOTE: We need to decide at which point we want to store a command.
        #       Do we want to store incorrect commands (with incorrect data)? It will end up with error anyway.
        #       What in case if data is correct but validation like above will not pass (EmailAddressNotUniq)?
        #       I decided to store only commands that have correct data and can pass all validations.
        @command_store.store(cmd)
      end
    end

    def with_developer(developer_uuid)
      repository = AggregateRoot::Repository.new(@event_store)
      developer  = Developer.new(developer_uuid)
      repository.with_aggregate(developer, stream_name(developer_uuid)) do |developer|
        yield developer
      end
    end

    def stream_name(developer_uuid)
      "ProjectManagement::Developer$#{developer_uuid}"
    end
  end
end
