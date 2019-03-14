module ProjectManagement
  class DevelopersCommandHandler
    def initialize(event_store:)
      @event_store               = event_store
      @developer_list_read_model = DeveloperList::Retriever.new(event_store: @event_store)
      @command_bus               = Arkency::CommandBus.new
      {
        ProjectManagement::RegisterDeveloper => method(:register),
        ProjectManagement::RemoveDeveloper   => method(:remove)
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
        encryption_key_repository = EncryptionKeyRepository.new
        encryption_key_repository.create(cmd.developer_uuid)

        with_developer(cmd.developer_uuid) do |developer|
          developer.register(cmd.fullname, cmd.email)
        end
      end
    end

    # TODO: Add validation is developer is assigned to the project.
    def remove(cmd)
      cmd.verify!

      ActiveRecord::Base.transaction do
        with_developer(cmd.developer_uuid) do |developer|
          developer.remove
        end
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
