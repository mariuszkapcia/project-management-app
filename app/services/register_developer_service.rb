class RegisterDeveloperService < DeveloperService
  def initialize(event_store:)
    @event_store = event_store
  end

  def call(command)
    with_developer(command.uuid) do |developer|
      developer.register(command.fullname, command.email)
    end
  end
end
