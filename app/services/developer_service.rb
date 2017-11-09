require 'aggregate_root'

class DeveloperService

  private

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
