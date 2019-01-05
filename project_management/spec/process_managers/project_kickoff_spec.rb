require_dependency 'project_management'

require_relative '../support/test_attributes'
require_relative '../support/test_actors'

module ProjectManagement
  RSpec.describe 'ProjectKickoff process manager' do
    include TestAttributes
    include TestActors

    specify 'happy path' do
      command_bus = FakeCommandBus.new
      process     = ProjectKickoff.new(event_store: event_store, command_bus: command_bus)

      given([
        project_registered,
        project_estimated,
        deadline_assigned_to_project
      ]).each do |event|
        process.call(event)
      end

      expect(command_bus.commands.size).to eq(1)
      expect(command_bus.commands.first.as_json).to eq(kick_off_project.as_json)
    end

    specify 'email is sent only once' do
      command_bus = FakeCommandBus.new
      process     = ProjectKickoff.new(event_store: event_store, command_bus: command_bus)

      given([
        project_registered,
        project_estimated,
        deadline_assigned_to_project,
        project_estimated
      ]).each do |event|
        process.call(event)
      end

      expect(command_bus.commands.size).to eq(1)
      expect(command_bus.commands.first.as_json).to eq(kick_off_project.as_json)
    end

    specify 'email is not sent without deadline' do
      command_bus = FakeCommandBus.new
      process     = ProjectKickoff.new(event_store: event_store, command_bus: command_bus)

      given([
        project_registered,
        project_estimated
      ]).each do |event|
        process.call(event)
      end

      expect(command_bus.commands.size).to eq(0)
    end

    specify 'email is not sent without estimation' do
      command_bus = FakeCommandBus.new
      process     = ProjectKickoff.new(event_store: event_store, command_bus: command_bus)

      given([
        project_registered,
        deadline_assigned_to_project
      ]).each do |event|
        process.call(event)
      end

      expect(command_bus.commands.size).to eq(0)
    end

    private

    class FakeCommandBus
      attr_reader :commands

      def call(command)
        @commands << command
      end

      def initialize
        @commands = []
      end
    end

    def given(events)
      events.each { |ev| event_store.append(ev) }
      events
    end

    def project_registered
      ProjectManagement::ProjectRegistered.new(data: {
        project_uuid: project_topsecretdddproject[:uuid],
        name:         project_topsecretdddproject[:name]
      })
    end

    def project_estimated
      ProjectManagement::ProjectEstimated.new(data: {
        project_uuid: project_topsecretdddproject[:uuid],
        hours:        project_topsecretdddproject[:estimation]
      })
    end

    def deadline_assigned_to_project
      ProjectManagement::DeadlineAssignedToProject.new(data: {
        project_uuid: project_topsecretdddproject[:uuid],
        deadline:     project_topsecretdddproject[:deadline]
      })
    end

    def kick_off_project
      ProjectManagement::KickOffProject.new(
        project_uuid: project_topsecretdddproject[:uuid]
      )
    end

    def event_store
      RailsEventStore::Client.new.tap do |es|
        ConfigureProjectManagementBoundedContext.new(event_store: es).call
      end
    end
  end
end
