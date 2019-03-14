module ProjectManagement
  class ProjectKickoff < ActiveJob::Base
    prepend RailsEventStore::AsyncHandler

    class State
      attr_reader :project_name

      def initialize
        @project_name        = nil
        @estimation_provided = false
        @deadline_provided   = false

        @version             = -1
        @event_ids_to_link   = []
      end

      def apply_project_registered(event)
        @project_name = event.data[:name]
      end

      def apply_project_estimated
        @estimation_provided = true
      end

      def apply_deadline_assigned_to_project
        @deadline_provided = true
      end

      def ready_to_kickoff?
        @project_name.present? && @estimation_provided && @deadline_provided
      end

      def apply(*events)
        events.each do |event|
          case event
          when ProjectManagement::ProjectRegistered then apply_project_registered(event)
          when ProjectManagement::ProjectEstimatedV2 then apply_project_estimated
          when ProjectManagement::DeadlineAssignedToProject then apply_deadline_assigned_to_project
          end

          @event_ids_to_link << event.event_id
        end
      end

      def load(stream_name, event_store:)
        events = event_store.read.stream(stream_name).forward.to_a
        events.each do |event|
          apply(event)
        end

        @version           = events.size - 1
        @event_ids_to_link = []

        self
      end

      def store(stream_name, event_store:)
        event_store.link(
          @event_ids_to_link,
          stream_name:      stream_name,
          expected_version: @version
        )

        @version          += @event_ids_to_link.size
        @event_ids_to_link = []
      rescue RubyEventStore::WrongExpectedVersion
        retry
      end
    end

    private_constant :State

    def perform(event)
      stream_name  = "ProjectKickoff$#{event.data[:project_uuid]}"

      state = State.new
      state.load(stream_name, event_store: event_store)
      process_already_ended = state.ready_to_kickoff?
      state.apply(event)
      state.store(stream_name, event_store: event_store)

      if !process_already_ended && state.ready_to_kickoff?
        command_bus.call(
          ProjectManagement::KickOffProject.new(
            project_uuid: event.data[:project_uuid]
          )
        )
      end
    end

    def event_store
      Rails.configuration.event_store
    end

    def command_bus
      Rails.configuration.command_bus
    end
  end
end
