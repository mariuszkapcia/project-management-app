module Notifications
  class NotificationsCommandHandler
    def initialize(event_store:)
      @event_store = event_store
      @command_bus = Arkency::CommandBus.new
      {
        Notifications::SendProjectKickoffEmail => method(:send_project_kickoff_email)
      }.map{ |klass, handler| @command_bus.register(klass, handler) }
    end

    def call(*commands)
      commands.each do |command|
        @command_bus.call(command)
      end
    end

    private

    def send_project_kickoff_email(cmd)
      cmd.verify!

      Notifications::ProjectKickoffMailer
        .new(event_store: @event_store)
        .deliver(cmd.project_uuid, cmd.project_name)
    end
  end
end
