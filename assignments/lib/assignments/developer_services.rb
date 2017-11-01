require 'aggregate_root'

module Assignments
  class DeveloperService

    private

    def with_developer(uuid)
      Assignments::Developer.new(uuid).tap do |developer|
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

  class RegisterDeveloperService < DeveloperService
    def initialize(event_store:)
      @event_store = event_store
    end

    def call(command)
      with_developer(command.uuid) do |developer|
        developer.register(command.name)
      end
    end
  end
end
